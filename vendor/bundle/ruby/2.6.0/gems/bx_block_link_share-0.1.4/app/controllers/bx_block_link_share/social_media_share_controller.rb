# frozen_string_literal: true

module BxBlockLinkShare
  class SocialMediaShareController < ApplicationController
    before_action :find_product, only: [:create]
    def create
      @share = BxBlockLinkShare::SocialMediaShare.new(social_media_share_params)
      @attachment_serializer = Array.new

      @product.images.each do |image|
        build_share_link(image)
      end
      @share.save

      render json: { data: { links: @attachment_serializer } }
    end

    private
      def find_product
        @product = BxBlockCatalogue::Catalogue.find(params[:social_media_share][:product_id])

        if @product.images.blank?
          render json: {errors: [
              {product: 'has no image.'},
            ]}, status: :unprocessable_entity and return
        end
      end

      def build_share_link(image)
        file_obj = @share.files.build()
        image.blob.open do |tempfile|
          obj = Aws::S3::Object.new(ENV['S3_BUCKET'], ('a'..'z').to_a.shuffle[0,10].join, ENV['S3_KEY_ID'])
          obj.upload_file(tempfile.path, acl:'public-read')
          file_obj.update_attributes(file_url: obj.public_url)
          @attachment_serializer << obj.public_url
        end
      end

      def social_media_share_params
        parameters = params.require(:social_media_share).permit(
          :product_id
        )
        parameters[:account_id] = @current_user.id
        parameters
      end
  end
end
