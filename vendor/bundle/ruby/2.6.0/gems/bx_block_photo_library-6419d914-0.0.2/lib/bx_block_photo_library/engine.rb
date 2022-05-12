# frozen_string_literal: true

module BxBlockPhotoLibrary
  class Engine < ::Rails::Engine
    isolate_namespace BxBlockPhotoLibrary
    config.generators.api_only = true

    config.builder = ActiveSupport::OrderedOptions.new

    initializer 'bx_block_photo_library.configuration' do |app|
      base = app.config.builder.root_url || ''
      app.routes.append do
        mount BxBlockPhotoLibrary::Engine => base + '/photo_library'
      end
    end
  end
end
