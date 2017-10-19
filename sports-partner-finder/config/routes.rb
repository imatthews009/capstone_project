Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :events do
    member do
        get 'join'
        get 'leave'
    end
  end
  resources :user_events, only: [:destroy]

  root "users#index"
end
