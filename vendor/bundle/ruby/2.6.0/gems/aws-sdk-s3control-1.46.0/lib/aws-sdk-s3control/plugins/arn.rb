# frozen_string_literal: true

require_relative '../arn/outpost_access_point_arn'
require_relative '../arn/outpost_bucket_arn'

module Aws
  module S3Control
    module Plugins
      # When an ARN is provided for :bucket or :name in S3Control operations,
      # this plugin resolves the request endpoint from the ARN when possible.
      # @api private
      class ARN < Seahorse::Client::Plugin
        option(
          :s3_use_arn_region,
          default: true,
          doc_type: 'Boolean',
          docstring: <<-DOCS) do |cfg|
For S3 and S3 Outposts ARNs passed into the `:bucket` or `:name`
parameter, this option will use the region in the ARN, allowing
for cross-region requests to be made. Set to `false` to use the
client's region instead.
        DOCS
          resolve_s3_use_arn_region(cfg)
        end

        # param validator is validate:50 (required to add account_id from arn)
        # endpoint is build:90 (populates the URI for the first time)
        # endpoint pattern is build:10 (prefix account id to host)
        def add_handlers(handlers, _config)
          handlers.add(ARNHandler, step: :validate, priority: 75)
          handlers.add(UrlHandler)
        end

        # After extracting out any ARN input, resolve a new URL with it.
        class UrlHandler < Seahorse::Client::Handler
          def call(context)
            if context.metadata[:s3_arn]
              ARN.resolve_url!(
                context.http_request.endpoint,
                context.metadata[:s3_arn][:arn],
                context.metadata[:s3_arn][:resolved_region],
                context.metadata[:s3_arn][:fips],
                context.metadata[:s3_arn][:dualstack],
                # if regional_endpoint is false, a custom endpoint was provided
                # in this case, we want to prefix the endpoint using the ARN
                !context.config.regional_endpoint
              )
            end
            @handler.call(context)
          end
        end

        # This plugin will extract out any ARN input and set context for other
        # plugins to use without having to translate the ARN again.
        class ARNHandler < Seahorse::Client::Handler
          def call(context)
            arn_member = _arn_member(context.operation.input.shape)
            if arn_member && (bucket = context.params[arn_member])
              resolved_region, arn = ARN.resolve_arn!(
                bucket,
                context.config.region,
                context.config.s3_use_arn_region
              )
              validate_outpost_dualstack!(context)
              if arn
                validate_config!(context, arn)

                if arn.is_a?(OutpostAccessPointARN) ||
                   arn.is_a?(OutpostBucketARN)
                  set_outpost_header!(context, arn)
                  # disable account_id prefix for outposts urls
                  context.config.disable_host_prefix_injection = true
                end
                set_account_param!(context, arn)

                # depending on the ARN's resource type, put the resource value
                # back onto params
                context.params[arn_member] = arn.input_member
                context.metadata[:s3_arn] = {
                  arn: arn,
                  resolved_region: resolved_region,
                  fips: context.config.use_fips_endpoint,
                  dualstack: extract_dualstack_config!(context)
                }
              end
            end
            @handler.call(context)
          end

          private

          # this validation has nothing to do with ARNs (can't be in
          # validate_config!) outposts does not support dualstack, so operations
          # using an outpost id should be validated too.
          def validate_outpost_dualstack!(context)
            if context.params[:outpost_id] && context[:use_dualstack_endpoint]
              raise ArgumentError,
                    'Cannot provide an Outpost ID when '\
                    '`:use_dualstack_endpoint` is set to true.'
            end
          end

          # This looks for BucketName or AccessPointName, but prefers BucketName
          # for CreateAccessPoint because it contains both but should not have
          # an Access Point ARN as AccessPointName.
          def _arn_member(input)
            input.members.each do |member, ref|
              if ref.shape.name == 'BucketName' ||
                 (ref.shape.name == 'AccessPointName' &&
                  input.name != 'CreateAccessPointRequest')
                return member
              end
            end
          end

          # other plugins use dualstack so disable it when we're done
          def extract_dualstack_config!(context)
            dualstack = context[:use_dualstack_endpoint]
            context[:use_dualstack_endpoint] = false if dualstack
            dualstack
          end

          def validate_config!(context, arn)
            if !arn.support_dualstack? && context[:use_dualstack_endpoint]
              raise ArgumentError,
                    'Cannot provide an Outpost Access Point or Bucket ARN '\
                    'when `:use_dualstack_endpoint` is set to true.'
            end
          end

          def set_outpost_header!(context, arn)
            context.http_request.headers['x-amz-outpost-id'] = arn.outpost_id
          end

          def set_account_param!(context, arn)
            if context.params[:account_id] &&
               context.params[:account_id] != arn.account_id
              raise ArgumentError,
                    'Cannot provide an Account ID that is different from the '\
                    'Account ID in the ARN.'
            end
            context.params[:account_id] = arn.account_id
          end
        end

        class << self
          # @api private
          def resolve_arn!(member_value, region, use_arn_region)
            if Aws::ARNParser.arn?(member_value)
              arn = Aws::ARNParser.parse(member_value)
              if arn.resource.include?('bucket')
                s3_arn = Aws::S3Control::OutpostBucketARN.new(arn.to_h)
              elsif arn.resource.include?('accesspoint')
                s3_arn = Aws::S3Control::OutpostAccessPointARN.new(arn.to_h)
              else
                raise ArgumentError,
                      'Only Outpost Bucket and Outpost Access Point ARNs are '\
                      'currently supported.'
              end
              s3_arn.validate_arn!
              validate_region_config!(s3_arn, region, use_arn_region)
              region = s3_arn.region if use_arn_region
              [region, s3_arn]
            else
              [region]
            end
          end

          # @api private
          def resolve_url!(url, arn, region, fips = false, dualstack = false, has_custom_endpoint = false)
            custom_endpoint = url.host if has_custom_endpoint
            url.host = arn.host_url(region, fips, dualstack, custom_endpoint)
            url
          end

          private

          def resolve_s3_use_arn_region(cfg)
            value = ENV['AWS_S3_USE_ARN_REGION'] ||
                    Aws.shared_config.s3_use_arn_region(profile: cfg.profile) ||
                    'true'
            value = Aws::Util.str_2_bool(value)
            # Raise if provided value is not true or false
            if value.nil?
              raise ArgumentError,
                    'Must provide either `true` or `false` for the '\
                    '`s3_use_arn_region` profile option or for '\
                    "ENV['AWS_S3_USE_ARN_REGION']."
            end
            value
          end

          def validate_region_config!(arn, region, use_arn_region)
            if use_arn_region &&
               !Aws::Partitions.partition(arn.partition).region?(region)
              raise Aws::Errors::InvalidARNPartitionError
            end

            if !use_arn_region && region != arn.region
              raise Aws::Errors::InvalidARNRegionError
            end
          end
        end
      end
    end
  end
end
