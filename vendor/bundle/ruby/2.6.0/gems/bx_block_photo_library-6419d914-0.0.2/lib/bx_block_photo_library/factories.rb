FactoryBot.define do
    factory :photo_lib, :class => 'BxBlockPhotoLibrary::PhotoLibrary' do
      photo do
        Rack::Test::UploadedFile.new(
          BxBlockPhotoLibrary::Engine.root.join('spec/support/unit/image_test.jpg'), 'image/jpeg'
        )
      end
      caption { "test" }
      account
    end
end
