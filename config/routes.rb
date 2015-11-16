Rails.application.routes.draw do
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]
  # root 'home#index', as: :root
  root 'posts#index', as: :root
  get '/about' => 'home#about'

  resources :posts do
    resources :comments, except: [:new, :show, :index]
    resources :likes, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :postvotes, only: [:create, :update, :destroy]
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :comments, only: :show do
    resources :commentlikes, only: [:create, :destroy]
    resources :commentvotes, only: [:create, :update, :destroy]
  end
end
