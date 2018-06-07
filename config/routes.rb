Rails.application.routes.draw do

  root to: 'top#index'

  get '/mypage', to: 'mypage#index'

  get '/login', to: 'sessions#index'

  # Twitter
  get 'auth/twitter/callback', to: 'sessions#create_twitter'

  # GitHub
  get 'auth/github/callback', to: 'sessions#callback'

  get '/logout', to: 'sessions#destroy'
end
