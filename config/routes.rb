Rails.application.routes.draw do
  resources :messages do
    collection do
      get 'new2'
      post 'create2'
    end
  end
  resources :orders do
    member do
      put 'approve'
      patch 'approve'
    end
  end
  # root to: 'visitors#index'
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  get 'home', to: 'visitors#index'

  devise_for :users
  resources :users do
    member do
      put 'update_role', to: 'users#update_role'
      patch 'update_role', to: 'users#update_role'
    end
  end
end
