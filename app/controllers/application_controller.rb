class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  private

    def current_user
      unless session[:user_id]
        return
      end
      @current_user ||= TwitterUser.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def authenticate
      return if logged_in?
      redirect_to root_path, alert: 'ログインしてください'
    end

end
