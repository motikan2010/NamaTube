class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  helper_method :current_user, :logged_in?, :get_name

  private

    def current_user
      if session[:user_id]
        case session[:auth_type]
          when 1 then
            @current_user ||= TwitterUser.find(session[:user_id])
          when 2 then
            @current_user ||= GithubUser.find(session[:user_id])
        end
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    # ユーザ名を取得
    def get_name
      case session[:auth_type]
        when 1 then
          current_user.nickname
        when 2 then
          current_user.name
      end
    end

    def authenticate
      if logged_in?
        return
      end
      redirect_to root_path, alert: 'ログインしてください'
    end

end
