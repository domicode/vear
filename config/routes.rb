Vear::Application.routes.draw do
  devise_for :users

  get :search, :controller => 'search'

  resources :users

  resources :posts
  resources :offers, :controller => 'posts', :type => 'Offer'
  resources :demands, :controller => 'posts', :type => 'Demand'

  authenticated :user do
    root :to => 'posts#index'
  end

  root :to => 'posts#index'
end
