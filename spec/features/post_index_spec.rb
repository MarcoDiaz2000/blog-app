require 'rails_helper'
RSpec.feature "User Posts index page", type: :feature do
  before do
    @user = User.create(name: "Marco", photo: 'https://...', bio: 'Text for Bio', posts_counter: 0)
    @post1 = Post.create(title: "Post 1", text: 'Text for post...', author: @user, comments_counter: 0, likes_counter: 0)
    @post2 = Post.create(title: "Post 2", text: 'Text for post...', author: @user, comments_counter: 0, likes_counter: 0)
    @post3 = Post.create(title: "Post 3", text: 'Text for post...', author: @user, comments_counter: 0, likes_counter: 0)
    @post4 = Post.create(title: "Post 4", text: 'Text for post...', author: @user, comments_counter: 0, likes_counter: 0)
    @post5 = Post.create(title: "Post 5", text: 'Text for post...', author: @user, comments_counter: 0, likes_counter: 0)
    @comment1 = Comment.create(author: @user, post: @post1, text: 'comment 1')
    @comment2 = Comment.create(author: @user, post: @post1, text: 'comment 2')
  end
 scenario "I can see the user's profile picture" do
    visit user_posts_path(@user)
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end
 scenario "I can see the user's username" do
    visit user_posts_path(@user)
    expect(page).to have_content(@user.name)
  end