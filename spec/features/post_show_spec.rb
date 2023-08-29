require 'rails_helper'

RSpec.feature "Post show page", type: :feature do
  before do
    @user = User.create(name: "Marco", photo: 'https://...', bio: 'Text for Bio', posts_counter: 0)
    @post = Post.create(title: "Post 1", text: 'Text for post...', author: @user, comments_counter: 0, likes_counter: 0)
    
    @comment1 = Comment.create(author: @user, post: @post, text: 'comment 1')
    @comment2 = Comment.create(author: @user, post: @post, text: 'comment 2')
  end

  scenario "I can see the post's title" do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.title)
  end

  scenario "I can see who wrote the post" do
    visit user_post_path(@user, @post)
    expect(page).to have_content("by #{@user.name}")
  end

  scenario "I can see how many comments it has" do
    visit user_post_path(@user, @post)
    expect(page).to have_content("Comments: 2")
  end

  scenario "I can see how many likes it has" do
    visit user_post_path(@user, @post)
    expect(page).to have_content("Likes: 0")
  end

  scenario "I can see the post body" do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@post.text)
  end

  scenario "I can see the username of each commentor" do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@comment1.author.name)
    expect(page).to have_content(@comment2.author.name)
  end

  scenario "I can see the comment each commentor left" do
    visit user_post_path(@user, @post)
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
  end
end
