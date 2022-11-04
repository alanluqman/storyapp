Rails.application.routes.draw do
devise_for :users
  root 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts
    get '/posts', to: 'users#posts', on: :member
  end

  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create]
  end

  resources :comments, only: [:edit, :destroy ]
  resources :likes, only: [:destroy]
end
