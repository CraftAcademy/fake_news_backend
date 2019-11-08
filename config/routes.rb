Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do 
    resources :articles, only: [:index, :create, :show, :update]
    resources :payments, only: [:create]
    resources :categories
  end
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
end