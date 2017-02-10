Rails.application.routes.draw do

  devise_for :users, path: :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  match '/contacts',     to: 'contacts#new',             via: 'get'
  resources "contacts", only: [:new, :create]
  resources :admins, only: [:index]

  resources :amenities do
    resources :pictures, only: [:new, :create, :destroy]
  end
  resources :properties do
    resources :pictures, only: [:new, :create, :destroy]
  end
  resources :users, only:[:index] do
    resources :services
  end
  resources :galleries, only:[:index, :show, :create] do
    resources :pictures, only: [:new, :create, :destroy]
  end
end
