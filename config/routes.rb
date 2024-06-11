Rails.application.routes.draw do
  devise_for :admins
  devise_for :workers, controllers: { 
    registrations: 'workers/registrations',
    sessions: 'workers/sessions'
 }
  
  resources :inventories
  resources :services
  resources :bookings, only: [:index, :new, :create]

  root "home#index"


  get "up" => "rails/health#show", as: :rails_health_check
  get "home" => "home#index"
  get "home/admin" => "home#show"
  get "worker-dashboard" => "worker_dashboard#index"
end
