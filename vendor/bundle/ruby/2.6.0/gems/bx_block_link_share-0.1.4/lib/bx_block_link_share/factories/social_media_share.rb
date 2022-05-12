# frozen_string_literal: true

FactoryBot.define do
  factory :social_media_share, class: 'BxBlockLinkShare::SocialMediaShare' do
    account_id         { FactoryBot.create(:account).id }
    is_whatsapp_shared  { false }
    is_facebook_shared  { false }
    is_twitter_shared   { false }
    is_instagram_shared { false }
  end
end
