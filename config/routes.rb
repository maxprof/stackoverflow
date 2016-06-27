Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", registrations: 'registrations' }
  get 'users/:id' => 'users#show', :as => :user
  resources :users, except: [:show]
  root 'home#index'
end
