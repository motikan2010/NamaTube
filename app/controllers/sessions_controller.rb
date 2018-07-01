class SessionsController < ApplicationController

  def index
    @alert = flash[:alert]
  end

  # Twitter
  def create_twitter
    user = User.twitter_find_or_create_from_auth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    session[:auth_type] = 1
    redirect_to root_path
  end

  # GitHub
  def callback
    auth = request.env['omniauth.auth']

    user = User.find_by(auth_type: 2, uid: auth['uid']) || User.github_create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:auth_type] = 2
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end
