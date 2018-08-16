Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'dashboard#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :user_mfa_session, only: %i[new create]

  resource :authentications, only: %i[show update]

end
