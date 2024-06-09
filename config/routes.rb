Rails.application.routes.draw do
  devise_for :workers, controllers: { registrations: 'workers/registrations' }
  
  resources :inventories
  resources :services
  resources :bookings, only: [:new, :create]  # Ensure bookings route for new and create actions
  resources :workers, only: [:index, :show, :edit, :update, :destroy]

  devise_for :admins

  root "worker_dashboard#index"

  get "up" => "rails/health#show", as: :rails_health_check
  get "home" => "home#index"
end
