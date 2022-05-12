module BxBlockLinkShare
  module PatchCatalogueBlockCatalogue
    extend ActiveSupport::Concern

    included do
      has_many :social_media_shares, class_name: 'BxBlockLinkShare::SocialMediaShare', dependent: :destroy
    end
  end
end
