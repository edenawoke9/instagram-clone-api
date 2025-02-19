class PostsController < ApplicationController
    before_action :authorize
    
    def index
      @posts = Post.includes(:user).order(created_at: :desc)
      render json: @posts, status: :ok  # Fixed typo: @posts instead of @post
    end
  
    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        render json: @post, status: :created
      else
        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @post = Post.find_by(id: params[:id])
      
      if @post.nil?
        render json: { error: 'Post not found' }, status: :not_found
        return
      end
      
      if @post.user == current_user
        @post.destroy
        render json: { message: 'Post deleted' }, status: :ok
      else
        render json: { error: 'Not authorized' }, status: :forbidden
      end
    end
  
    private 
  
    def post_params
      params.require(:post).permit(:image, :description, :likes)  # Fixed typo: changed expect to require
    end
  end
  