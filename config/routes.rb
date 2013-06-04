Vear::Application.routes.draw do
  devise_for :users

  get :search, :controller => 'search'

  resources :users do
    get :posts
  end

  resources :posts do
    resources :messages
  end

  authenticated :user do
    root :to => 'posts#index'
  end

  root :to => 'posts#index'
end
