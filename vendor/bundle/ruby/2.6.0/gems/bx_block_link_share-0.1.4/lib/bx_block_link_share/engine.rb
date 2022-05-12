module BxBlockLinkShare

  class Engine < ::Rails::Engine
    isolate_namespace BxBlockLinkShare
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_link_share.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockLinkShare::Engine => base + '/link_share'
      end
    end
  end

end

