Rails.application.routes.draw do

  root to: 'top#index'

  post '/videos/confirm', to: 'video_rails#confirm'
  resources :video_rails, :path => 'videos'

  get '/mypage', to: 'mypage#index'

  get '/login', to: 'sessions#index'
  get '/logout', to: 'sessions#destroy'
  get 'auth/twitter/callback', to: 'sessions#create_twitter' # Twitter
  get 'auth/github/callback', to: 'sessions#callback' # GitHub

end
