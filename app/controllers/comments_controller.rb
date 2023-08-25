class CommentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author_id = current_user.id

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment successfully created'
    else
      render 'posts/show', alert: 'There was an error creating the comment'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
