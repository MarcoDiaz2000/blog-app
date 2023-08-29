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
scenario "I can see the number of posts the user has written" do
    visit user_posts_path(@user)
    expect(page).to have_content("Number of posts: 5")
  end
  scenario "I can see a post's title" do
    visit user_posts_path(@user)
    expect(page).to have_content("Post 5")
  end
 scenario "I can see some of the post's body" do
    visit user_posts_path(@user)
    expect(page).to have_content("Text for post...")
  end
  scenario "I can see the first comments on a post" do
    visit user_post_path(@user, @post1)
    expect(page).to have_content("comment 1")
  end
  scenario "I can see how many comments a post has" do
    visit user_posts_path(@user, @post2)
    expect(page).to have_content("Comments: 0")
  end
