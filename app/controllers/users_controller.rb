class UsersController < ApplicationController
  before_action :set_user, only: [:followers, :following]
  def index
    @users = User.all
    render json: @users, only: [:bio, :name, :username, :image], status: :ok
  end
  
    def new
      @user = User.new
    end
    def followers
      @followers = @user.followers
      render json: @followers.map  { |follow| follow.followers}
    end
  
    def following
      @following = @user.following
      render json: @following.map  { |follow| follow.following }
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
    def set_user
      @user = User.find(params[:id])
    end
  
    def allow_params
      params.require(:user).permit(:email,:bio,:name,:image, :username, :phonenumber, :password, :password_confirmation)
    end
  end
  