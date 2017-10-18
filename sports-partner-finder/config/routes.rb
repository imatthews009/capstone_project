Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  root "users#index"
end
