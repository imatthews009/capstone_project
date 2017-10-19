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

  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end

  resources :conversations do
    resources :messages
  end

  root "users#index"
end
