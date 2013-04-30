Vear::Application.routes.draw do
  devise_for :users, :controllers => {sessions: 'sessions'}

  resources :users

  authenticated :user do
    root :to => 'users#index'
  end

  resources :users do
    resources :posts do
      collection do
        get 'page/:page', :action => :index
      end
    end
  end

  resources :posts do
    collection do
      get 'page/:page', :action => :index
    end
  end

  root :to => 'posts#index'
end
