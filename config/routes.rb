Rails.application.routes.draw do
  devise_for :admins, controllers: { 
    registrations: 'workers/registrations',
    sessions: 'workers/sessions'
 }
  devise_for :workers, controllers: { 
    registrations: 'workers/registrations',
    sessions: 'workers/sessions'
 }
  
  resources :inventories
  resources :services
  resources :bookings

  root "home#index"


  get "up" => "rails/health#show", as: :rails_health_check
  get "home" => "home#index"
  get "home/admin" => "home#show"
  get "worker-dashboard" => "worker_dashboard#index"
end
