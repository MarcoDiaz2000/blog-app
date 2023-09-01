class Api::V1::CommentsController < ActionController::API
def index
    post = Post.find(params[:post_id])
    render json: post.comments
  end
 def create
    user = User.find_by(email: params[:email])
    logger.debug "User found: #{user.inspect}"
    if user&.authenticate(params[:password])
      logger.debug "User authenticated"
      token = JwtManager.encode(user_id: user.id)
      render json: { auth_token: token }
    else
      logger.debug "Invalid credentials"
      render json: { error: 'Invalid credentials' }, status: 401
    end
  end

 private
  def comment_params
    params.require(:comment).permit(:text)
  end
end
