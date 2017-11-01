Rails.application.routes.draw do
  root to: 'sessions#login'
  get 'signup', to: 'users#new'
  post 'verifyuser', to: 'users#create'
  get 'login', to: 'sessions#login'
  post 'authorize_user', to: 'sessions#authorize_user'
  get 'logout', to: 'sessions#logout'
  get 'search_caregivers', to: 'users#search'

  resources :message_thread, only: [:index, :new, :create, :update]
  get 'message_thread/:id/messages', to: 'message_thread#show'
  post 'message_thread/:id/messages', to: 'message_thread#reply'
  get 'message_thread/:id/conversation', to: 'message_thread#conversation'
end
