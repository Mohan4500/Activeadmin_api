module BxBlockPhotoLibrary
  class PhotoLibrarySerializer
    include FastJsonapi::ObjectSerializer
    attributes *[
      :id,
      :photo,
      :caption,
      :account_id,
      :created_at,
      :updated_at,
      :account
    ]
  end
end
