class SessionsController < ApplicationController

  def index

  end

  # Twitter
  def create_twitter
    user = TwitterUser.find_or_create_from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path
  end

  # Github
  def create_github
    user = GithubUser.find_or_create_from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def callback
    auth = request.env['omniauth.auth']

    user = GithubUser.find_by(provider: auth['provider'], uid: auth['uid']) || GithubUser.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end
