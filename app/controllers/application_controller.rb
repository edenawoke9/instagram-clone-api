class ApplicationController < ActionController::API
  before_action :authorize

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authorize
    render json: { message: "Not authorized" }, status: :unauthorized if current_user.nil?
  end
end