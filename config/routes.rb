Vear::Application.routes.draw do
  devise_for :users

  get :search, :controller => 'search'

  resources :users

  resources :posts

  resources :messages

  authenticated :user do
    root :to => 'posts#index'
  end

  root :to => 'posts#index'
end
