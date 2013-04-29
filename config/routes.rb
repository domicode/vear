Vear::Application.routes.draw do
  resources :posts do
    collection do
      get 'page/:page', :action => :index
    end
  end

  root :to => 'posts#index'
end
