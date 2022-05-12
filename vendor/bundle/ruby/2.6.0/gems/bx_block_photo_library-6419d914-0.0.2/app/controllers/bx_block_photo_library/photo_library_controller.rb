module BxBlockPhotoLibrary
  class PhotoLibraryController < ApplicationController
    include BuilderJsonWebToken::JsonWebTokenValidation
    before_action :current_user

    def index
      @photo = PhotoLibrary.where(account_id: @current_user.id)
      if @photo.present?
        render json: PhotoLibrarySerializer.new(@photo, meta: {message: 'List of photos.'
        }).serializable_hash, status: :ok
      else
        render json: {errors: [
          {message: 'No photos present.'},
        ]}, status: :ok
      end
    end

    def show
      @photo = PhotoLibrary.find_by(id: params[:id], account_id: @current_user.id)
      render json: PhotoLibrarySerializer.new(@photo, meta: {message: 'Success.'
      }).serializable_hash, status: :ok
    end

    def create
      @uploaded_photos = uploaded_photos_data.select { |photo| photo.save }
      if @uploaded_photos.count > 0
        render json: PhotoLibrarySerializer.new(@uploaded_photos, meta: {
          message: "Success."}).serializable_hash, status: :created
      else
        render json: {errors: format_activerecord_errors(@photo.errors)},
               status: :unprocessable_entity
      end
    end

    def destroy
      @photo = PhotoLibrary.find_by(id: params[:id], account_id: @current_user.id)
      return render json: {message: "Photo does not exist."},
                    status: :unprocessable_entity if !@photo.present?
      if @photo.destroy
        render json: {message: "Deleted."}, status: :ok
      else
        render json: {errors: format_activerecord_errors(@photo.errors)},
               status: :unprocessable_entity
      end
    end

    private

    def photo_params
      params.require(:photo_library).permit(:caption, :photo).merge(account_id: @current_user.id)
    end

    def uploaded_photos_data
      photos = []
      params[:photo_library][:photo_attributes].each do |_, pl|
        photos << PhotoLibrary.new(caption: pl[:caption],
                                   photo: pl[:photo],
                                   account_id: @current_user.id)
      end
      photos
    end
  end
end
