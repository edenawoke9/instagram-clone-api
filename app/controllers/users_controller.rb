class UsersController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(allow_params)
      if @user.save
        render json: { message: "Created successfully" }, status: :created
      else
        render json: { message: "Fix your credentials", errors: @user.errors.full_messages }, status: :bad_request
      end
    end
  
    private
  
    def allow_params
      params.require(:user).permit(:email, :username, :phonenumber, :password, :password_confirmation)
    end
  end
  