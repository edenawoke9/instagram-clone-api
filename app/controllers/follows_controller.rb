class FollowsController < ApplicationController
  
    def create
      user = User.find(params[:following_id])
      current_user.following << user
      render json: { message: "Successfully followed #{user.username}" }, status: :created
    end
  
    def destroy
      user = User.find(params[:id])
      current_user.following.delete(user)
      render json: { message: "Successfully unfollowed #{user.username}" }, status: :ok
    end
  end
  