Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'

  namespace :api, defaults: { format: :json } do
    resources :omniauth, only: [:create] do
      post :sign_in, on: :collection
    end
    resources :posts, only: [:index]
  end
end
