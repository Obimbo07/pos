Rails.application.routes.draw do
  devise_for :workers, controllers: { registrations: 'workers/registrations' }
  
  resources :inventories
  resources :services
  resources :bookings, only: [:index, :new, :create]
  resources :workers, only: [:index, :show, :edit, :update, :destroy]

  devise_for :admins

  root "home#index"

  get "up" => "rails/health#show", as: :rails_health_check
  get "home" => "home#index"
end
