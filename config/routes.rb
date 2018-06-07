Rails.application.routes.draw do

  # Twitter
  get 'auth/twitter/callback', to: 'sessions#create'

  # GitHub
  get 'auth/github/callback', to: 'sessions#callback'

  get '/logout', to: 'sessions#destroy'

  root 'sessions#index'
end
