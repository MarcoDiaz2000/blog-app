class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.author_id)
    @comments = @post.comments
  end
end
