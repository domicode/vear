Vear::Application.routes.draw do
  devise_for :users, :controllers => {sessions: 'sessions'}

  resources :users

  authenticated :user do
    root :to => 'users#index'
  end

  resources :users do
    resources :posts
  end

  resources :posts

  root :to => 'posts#index'
end
