class Api::V1::CommentsController < ActionController::API
def index
    post = Post.find(params[:post_id])
    render json: post.comments
  end
end
