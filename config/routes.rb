Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'
  namespace :api do
    namespace :v1 do
      post 'user_token' => 'user_token#create'
      post '/users',            to: 'users#create'
      get '/users/:user_id',    to: 'users#show'
      get '/users',             to: 'users#index'
      get '/stats/:username',   to: 'stats#show'
      post '/login',            to: 'sessions#create'
      post '/logout',           to: 'sessions#destroy'
      get '/logged_in',         to: 'sessions#is_logged_in?'
      post '/friendly_games',   to: 'friendly_games#create'
      patch '/friendly_games',  to: 'friendly_games#update'
      post '/fishing',          to: 'ai_games#create'
    end
  end
end
