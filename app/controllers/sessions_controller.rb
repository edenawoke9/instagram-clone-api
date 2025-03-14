class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:create]
  def new
    # Render the login form (if needed)
  end

  def create
    user = User.find_by(email: params[:email]) # Look up user by email

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id # Store user ID in the session
      render json: { message: "Authenticated successfully" }, status: :ok
    else
      render json: { message: "The credentials are not correct" }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil # Clear the session
    render json: { message: "Logged out successfully" }, status: :ok
  end
end