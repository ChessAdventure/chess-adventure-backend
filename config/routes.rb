Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/users',         to: 'users#create'
  get '/users/:user_id', to: 'users#show'
  get '/users',          to: 'users#index'
  post '/login',         to: 'sessions#create'
  post '/logout',        to: 'sessions#destroy'
  get '/logged_in',      to: 'sessions#is_logged_in?'
end
