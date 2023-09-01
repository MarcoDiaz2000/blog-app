class Api::V1::PostsController < ActionController::API
  def index
    @posts = User.find(params[:user_id]).posts
    render json: @posts
  end
end
