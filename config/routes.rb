Rails.application.routes.draw do
  get 'errors/not_found'

  get 'errors/internal_server_error'

  resources :tags
  resources :answers do
    member do
      put "like" => "answers#upvote"
      put "unlike" => "answers#downvote"
    end
  end
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
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end
