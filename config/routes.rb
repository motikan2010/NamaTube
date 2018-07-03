Rails.application.routes.draw do

  # root to: 'top#index' # TODO トップを用意
  root to: 'video_rails#index'

  post '/videos/confirm', to: 'video_rails#confirm'
  resources :video_rails, :path => 'videos'

  get '/mypage', to: 'mypage#index'
  get '/mypage/videos', to: 'mypage#videos'

  get '/login', to: 'sessions#index', as: 'login'
  get '/logout', to: 'sessions#destroy'
  get 'auth/twitter/callback', to: 'sessions#create_twitter' # Twitter
  get 'auth/github/callback', to: 'sessions#callback' # GitHub

end
