# frozen_string_literal: true

module BxBlockPhoneVerification
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockPhoneVerification
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_phone_verification.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockPhoneVerification::Engine => base + '/phone_verification'
      end
    end
  end
end
