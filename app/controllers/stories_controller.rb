class StoriesController < ApplicationController
    
  
    def index
      stories = Story.includes(:user).order(created_at: :desc)
      render json: stories.as_json(include: { user: { only: [:name,:image,:username] } }), status: :ok
    end
  
    def create
      @story = current_user.stories.build(story_params)
      if @story.save
        render json: { message: "Story created" }, status: :created
      else
        render json: { errors: @story.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @story = Story.find_by(id: params[:id])
      if @story.nil?
        render json: { error: "Story not found" }, status: :not_found
        return
      end
  
      if @story.user == current_user
        @story.destroy
        render json: { message: "Story deleted" }, status: :ok
      else
        render json: { error: "Not authorized" }, status: :forbidden
      end
    end
  
    private
  
    def story_params
      params.require(:story).permit(:body, :image)
    end
  end
  