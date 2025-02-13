class SessionsController < ApplicationController
    def new
    end
  
    def create
      # Check for email, phone_number, or username in params
      user = User.find_by("email = ? OR phonenumber = ? OR username = ?", params[:email], params[:phone_number], params[:username])
  
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        render json: { message: "Authenticated successfully" }, status: :ok
      else
        render json: { message: "The credentials are not correct" }, status: :unauthorized
      end
    end
  
    def destroy
      session[:user_id] = nil
      render json: { message: "Logged out successfully" }, status: :ok
    end
  end
  