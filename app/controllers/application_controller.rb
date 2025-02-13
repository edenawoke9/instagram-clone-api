class ApplicationController < ActionController::API
    private
  
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  
    def authorize
      # For API, you can return an error or status if user is not authorized
      render json: { message: "Not authorized" }, status: :unauthorized if current_user.nil?
    end
  end
  