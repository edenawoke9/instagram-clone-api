class CommentsController < ApplicationController
    before_action :authorize
  
    def index
      @comments = Comment.includes(:user, :post).order(created_at: :desc)
      render json: @comments, status: :ok
    end
  
    def create
      @comment = current_user.comments.build(comment_params)
      if @comment.save
        render json: { message: "Created successfully" }, status: :created
      else
        render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment = Comment.find_by(id: params[:id])
      
      if @comment.nil?
        render json: { error: "Comment not found" }, status: :not_found
        return
      end
  
      if @comment.user == current_user
        @comment.destroy
        render json: { message: "Comment deleted" }, status: :ok
      else
        render json: { error: "Not authorized" }, status: :forbidden
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
  