Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :v1, defaults: { format: :json } do 
    resources :articles, only: [:index]
  end
end