Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'dashboard#index'

  resources :users do
    resources :exercises
  end

  resources :friendships, only: [:show, :create, :destroy]
  resources :messages, only: [:create]

  mount ActionCable.server => '/cable'
end
