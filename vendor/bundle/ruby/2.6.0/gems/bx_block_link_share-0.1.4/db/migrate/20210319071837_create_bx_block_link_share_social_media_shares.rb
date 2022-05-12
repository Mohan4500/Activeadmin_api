# frozen_string_literal: true

class CreateBxBlockLinkShareSocialMediaShares < ActiveRecord::Migration[6.0]
  def change
    create_table :social_media_shares do |t|
      t.bigint :account_id
      t.bigint :product_id
      t.timestamps
    end
  end
end
