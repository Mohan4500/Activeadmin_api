module BxBlockPhotoLibrary
    class PhotoLibrary < ApplicationRecord
        self.table_name = :photo_libraries

        belongs_to :account, class_name: 'AccountBlock::Account'

        mount_uploader :photo, PhotoLibraryUploader

        validates :photo, presence: { message: "Photo required." }
    end
end
