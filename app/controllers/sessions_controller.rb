class SessionsController < ApplicationController
  def new
  end

  def create
   
    user = User.find_by("email = ? OR phonenumber = ? OR username = ?", params[:email], params[:phone_number], params[:username])

    if user && user.authenticate(params[:password])
      token = generate_token(user)
      render json: { message: "Authenticated successfully", token: token }, status: :ok
    else
      render json: { message: "The credentials are not correct" }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: "Logged out successfully" }, status: :ok
  end

  private

  # Generate JWT Token
  def generate_token(user)
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }  
    JWT.encode(payload, Rails.application.secret_key_base)  
  end
end
