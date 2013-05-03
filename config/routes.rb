Vear::Application.routes.draw do
  devise_for :users

  resources :users

  resources :posts

  authenticated :user do
    root :to => 'users#index'
  end

  root :to => 'posts#index'
end
