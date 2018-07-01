class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  private

    def current_user
      if session[:user_id]
        @current_user ||= User.where(id: session[:user_id], auth_type: session[:auth_type]).first
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def authenticate
      if logged_in?
        return
      end
      redirect_to login_path, alert: 'ログインしてください'
    end

end
