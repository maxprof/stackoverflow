Rails.application.routes.draw do
  resources :tags
  resources :answers
  resources :questions do
    member do
      put "like" => "questions#upvote"
      put "unlike" => "questions#downvote"
    end
  end
  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", registrations: 'registrations' }
  get 'users/:id' => 'users#show', :as => :user
  resources :users, except: [:show]
  root 'home#index'

end
