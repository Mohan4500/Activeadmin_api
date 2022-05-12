# frozen_string_literal: true

module BxBlockLinkShare
  class SocialMediaShare < ApplicationRecord
    self.table_name = 'social_media_shares'

    belongs_to :account, class_name: 'AccountBlock::Account'
    belongs_to :product, class_name: 'BxBlockCatalogue::Catalogue'
    has_many :files
  end
end
