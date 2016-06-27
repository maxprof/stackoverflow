Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", registrations: 'registrations' }
  root 'home#index'
end
