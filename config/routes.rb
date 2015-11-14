Rails.application.routes.draw do
  # root 'home#index', as: :root
  root 'posts#index', as: :root
  get '/about' => 'home#about'
  resources :posts do
    resources :comments, except: [:new, :show, :index]
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end
