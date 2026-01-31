Rails.application.routes.draw do

  devise_for :users

  mount ActionCable.server => '/cable'
  root "home#index"
  get 'profile', to: 'profiles#show', as: :my_profile
  get 'profile/:id', to: 'profiles#show', as: :profile
  patch "profile", to: "profiles#update"

resources :posts do
    resource :like, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
end
 resources :conversations, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end
end
