Rails.application.routes.draw do
    namespace :v1, defaults: { format: :json } do 
      resources :article, only: [:index]
  end
end