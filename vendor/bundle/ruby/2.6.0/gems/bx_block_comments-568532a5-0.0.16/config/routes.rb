BxBlockComments::Engine.routes.draw do

  if defined?(Rswag)
    mount Rswag::Ui::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Ui)
    mount Rswag::Api::Engine => '/api-docs' if defined?(Rswag) && defined?(Rswag::Api)
  end

  resources :comments, :only => [:index, :show, :create, :update, :destroy] do
    collection do
      get :search
    end
    member do
      post :like
      post :dislike
    end
  end
end
