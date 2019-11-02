class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    helper_method :current_user, :logged_in?

    private

    def current_user
      return unless session[:user_id]
      @current_user ||= User.find_by(uid: session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
end
