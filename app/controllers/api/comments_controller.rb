class Api::V1::CommentsController < ActionController::API
  def index
    post = Post.find(params[:post_id])
    render json: post.comments
  end

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(comment_params)
    comment.author_id = current_user.id

    if comment.save
      render json: { notice: 'Comment successfully created', comment: }, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
