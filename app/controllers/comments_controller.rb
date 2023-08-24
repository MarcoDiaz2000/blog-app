class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment successfully created'
    else
      render 'posts/show', alert: 'There was an error creating the comment'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end