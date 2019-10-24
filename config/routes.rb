Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do 
    resources :articles, only: [:index]
  end
end