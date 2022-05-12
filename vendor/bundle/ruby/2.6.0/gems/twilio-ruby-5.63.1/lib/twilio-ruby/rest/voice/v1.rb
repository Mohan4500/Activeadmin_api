##
# This code was generated by
# \ / _    _  _|   _  _
#  | (_)\/(_)(_|\/| |(/_  v1.0.0
#       /       /
#
# frozen_string_literal: true

module Twilio
  module REST
    class Voice
      class V1 < Version
        ##
        # Initialize the V1 version of Voice
        def initialize(domain)
          super
          @version = 'v1'
          @archived_calls = nil
          @byoc_trunks = nil
          @connection_policies = nil
          @dialing_permissions = nil
          @ip_records = nil
          @source_ip_mappings = nil
        end

        ##
        # @param [Date] date The date of the Call in UTC.
        # @param [String] sid The Twilio-provided Call SID that uniquely identifies the
        #   Call resource to delete
        # @return [Twilio::REST::Voice::V1::ArchivedCallContext] if sid was passed.
        # @return [Twilio::REST::Voice::V1::ArchivedCallList]
        def archived_calls(date=:unset, sid=:unset)
          if date.nil?
              raise ArgumentError, 'date cannot be nil'
          end
          if sid.nil?
              raise ArgumentError, 'sid cannot be nil'
          end
          if date == :unset && sid == :unset
              @archived_calls ||= ArchivedCallList.new self
          else
              ArchivedCallContext.new(self, date, sid)
          end
        end

        ##
        # @param [String] sid The Twilio-provided string that uniquely identifies the BYOC
        #   Trunk resource to fetch.
        # @return [Twilio::REST::Voice::V1::ByocTrunkContext] if sid was passed.
        # @return [Twilio::REST::Voice::V1::ByocTrunkList]
        def byoc_trunks(sid=:unset)
          if sid.nil?
              raise ArgumentError, 'sid cannot be nil'
          end
          if sid == :unset
              @byoc_trunks ||= ByocTrunkList.new self
          else
              ByocTrunkContext.new(self, sid)
          end
        end

        ##
        # @param [String] sid The unique string that we created to identify the Connection
        #   Policy resource to fetch.
        # @return [Twilio::REST::Voice::V1::ConnectionPolicyContext] if sid was passed.
        # @return [Twilio::REST::Voice::V1::ConnectionPolicyList]
        def connection_policies(sid=:unset)
          if sid.nil?
              raise ArgumentError, 'sid cannot be nil'
          end
          if sid == :unset
              @connection_policies ||= ConnectionPolicyList.new self
          else
              ConnectionPolicyContext.new(self, sid)
          end
        end

        ##
        # @return [Twilio::REST::Voice::V1::DialingPermissionsContext]
        def dialing_permissions
          @dialing_permissions ||= DialingPermissionsList.new self
        end

        ##
        # @param [String] sid The Twilio-provided string that uniquely identifies the IP
        #   Record resource to fetch.
        # @return [Twilio::REST::Voice::V1::IpRecordContext] if sid was passed.
        # @return [Twilio::REST::Voice::V1::IpRecordList]
        def ip_records(sid=:unset)
          if sid.nil?
              raise ArgumentError, 'sid cannot be nil'
          end
          if sid == :unset
              @ip_records ||= IpRecordList.new self
          else
              IpRecordContext.new(self, sid)
          end
        end

        ##
        # @param [String] sid The Twilio-provided string that uniquely identifies the IP
        #   Record resource to fetch.
        # @return [Twilio::REST::Voice::V1::SourceIpMappingContext] if sid was passed.
        # @return [Twilio::REST::Voice::V1::SourceIpMappingList]
        def source_ip_mappings(sid=:unset)
          if sid.nil?
              raise ArgumentError, 'sid cannot be nil'
          end
          if sid == :unset
              @source_ip_mappings ||= SourceIpMappingList.new self
          else
              SourceIpMappingContext.new(self, sid)
          end
        end

        ##
        # Provide a user friendly representation
        def to_s
          '<Twilio::REST::Voice::V1>'
        end
      end
    end
  end
end