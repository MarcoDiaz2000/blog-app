class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, only: %i[new create]

  def destroy
    author = @post.author
    @post.destroy
    redirect_to user_posts_path(author), notice: 'Post was successfully deleted.'
  end

  def index
    @user = User.includes(posts: %i[comments likes]).find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.author_id)
    @comments = @post.comments
    @current_like = @post.likes.find_by(author_id: current_user.id)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
