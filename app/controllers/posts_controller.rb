class PostsController < ApplicationController
     before_action :authorize
    
    def index
      posts = Post.includes(:user).order(created_at: :desc)
      render json: posts.as_json(include: { user: { only: [:name,:image,:username] } }), status: :ok
    end
    def reel 
      posts=Post.includes(:user).where(is_video:true).order(created_at: :desc)
      render json: posts, status: :ok

    end
    def individual_post
      posts=current_user.posts
      render json: posts, status: :ok
    end
    def get_comments
      comments = Comment.where(post_id: params[:post_id]).includes(:user)
      render json: comments.as_json(include: { user: { only: [:image, :name, :username] } }), status: :ok
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
      params.require(:post).permit(:image, :description, :likes)  
    end
  end
  