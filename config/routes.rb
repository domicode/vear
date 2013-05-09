Vear::Application.routes.draw do
  devise_for :users

  resources :users

  resources :posts
  resources :offers, :controller => 'posts', :type => 'Offer'
  resources :demands, :controller => 'posts', :type => 'Demand'

  authenticated :user do
    root :to => 'users#index'
  end

  root :to => 'posts#index'
end
