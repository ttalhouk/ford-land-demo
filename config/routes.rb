Rails.application.routes.draw do

  devise_for :users, path: :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  match '/contacts',     to: 'contacts#new',             via: 'get'
  resources "contacts", only: [:new, :create]


  namespace :admin do
    get '/', to:'home#index'
    resources :amenities do
      get "delete"
      resources :pictures, only: [:new, :create, :destroy]
    end
    resources :properties do
      get "delete"
      resources :pictures, only: [:new, :create, :destroy]
    end
    resources :users, only:[:index, :show, :edit, :update, :destroy] do
      get "delete"
      resources :services, only:[:index]
    end
    resources :services, except: [:new, :create] do
      get "delete"
    end
    resources :galleries, only:[:index, :show] do
      resources :pictures, only: [:new, :create, :destroy]
    end
  end

  resources :amenities, only:[:index, :show]
  resources :properties, only:[:index, :show]
  resources :users, only:[:index] do
    resources :services
  end
  resources :galleries, only:[:index, :show]
end
