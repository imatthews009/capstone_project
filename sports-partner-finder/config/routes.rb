Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    resources :chats, only: [:index, :show, :create]
  end 
  resources :events do
    member do
        get 'join'
        get 'leave'
    end
  end
  resources :user_events, only: [:destroy]

  resources :messages, only:[:create]



  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'


  root "users#index"
end
