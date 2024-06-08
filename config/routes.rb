Rails.application.routes.draw do
  devise_for :workers
  # Resource routes for inventories, services, and workers
  resources :inventories
  resources :services
  resources :workers, only: [:index, :show, :edit, :update, :destroy] # Avoid conflicts with Devise routes

  # Devise routes for admins
  devise_for :admins

  # Root route
  root "worker_dashboard#index"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Other routes can be defined here
end
