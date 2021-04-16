Rails.application.routes.draw do
  get 'friendly_games/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
  namespace :api do
    namespace :v1 do
      post '/users',            to: 'users#create'
      get '/users/:user_id',    to: 'users#show'
      get '/users',             to: 'users#index'
      post '/login',            to: 'sessions#create'
      post '/logout',           to: 'sessions#destroy'
      get '/logged_in',         to: 'sessions#is_logged_in?'
      post '/friendly_games',   to: 'friendly_games#create'
      patch '/friendly_games',  to: 'friendly_games#upate'
    end
  end
end
