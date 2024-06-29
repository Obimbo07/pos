Rails.application.routes.draw do
  resources :mpesas
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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

  post 'stkpush', to: 'mpesas#stkpush'
  post 'stkquery', to: 'mpesas#stkquery'
  post 'pay', to: 'mpesas#pay'
  get "up" => "rails/health#show", as: :rails_health_check
  get "home" => "home#index"
  get "worker" => "worker_dashboard#index"
end
