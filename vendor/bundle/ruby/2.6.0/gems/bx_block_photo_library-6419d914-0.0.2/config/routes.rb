BxBlockPhotoLibrary::Engine.routes.draw do
  resources :photo_library, :only => [:index, :show, :create, :destroy]
end
