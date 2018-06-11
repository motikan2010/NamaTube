Rails.application.routes.draw do

  root to: 'top#index'

  post '/videos/confirm', to: 'videos#confirm'
  resources :videos

  get '/mypage', to: 'mypage#index'

  get '/login', to: 'sessions#index'
  get '/logout', to: 'sessions#destroy'
  get 'auth/twitter/callback', to: 'sessions#create_twitter' # Twitter
  get 'auth/github/callback', to: 'sessions#callback' # GitHub

end
