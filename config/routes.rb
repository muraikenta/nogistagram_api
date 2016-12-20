Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'

  namespace :api, defaults: { format: :json } do
    get '/seach' => 'search#index'
    resources :omniauth, only: [:create] do
      post :sign_in, on: :collection
    end
    resources :users, only: [] do
      get :posts, on: :member
    end
    resources :posts, only: [:create] do
      get :timeline, on: :collection
    end
    resources :likes, only: [:create] do
      delete :destroy, on: :collection
    end
  end
end
