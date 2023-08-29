require 'rails_helper'

RSpec.feature 'User show page', type: :feature do
  before do
    @user = User.create(name: 'Marco', photo: 'https://image.com/image.jpg', bio: 'Text for Bio', posts_counter: 0)
    5.times do |i|
      Post.create(title: "Post #{i + 1}", author: @user, comments_counter: 0, likes_counter: 0)
    end
  end

  scenario "I can see the user's profile picture" do
    visit user_path(@user)
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end

  scenario "I can see the user's username" do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
  end

  scenario 'I can see the number of posts the user has written' do
    visit user_path(@user)
    expect(page).to have_content('Number of posts: 5')
  end

  scenario "I can see the user's bio" do
    visit user_path(@user)
    expect(page).to have_content(@user.bio)
  end

  scenario "I can see the user's first 3 posts" do
    visit user_path(@user)
    @user.three_most_recent_posts.each do |post|
      expect(page).to have_content(post.title)
    end
  end

  scenario "I can see a button that lets me view all of a user's posts" do
    visit user_path(@user)
    expect(page).to have_link('See all posts')
  end

  scenario "When I click a user's post, it redirects me to that post's show page" do
    visit user_path(@user)
    first_post_title = @user.three_most_recent_posts.first.title
    click_link(first_post_title)
    expect(page).to have_content(first_post_title)
  end

  scenario "When I click to see all posts, it redirects me to the user's post's index page" do
    visit user_path(@user)
    click_link('See all posts')
    expect(page.current_path).to eq(user_posts_path(@user))
  end

  scenario "I can see only the user's three most recent posts" do
    visit user_path(@user)
    displayed_posts = all('.post-row h3').map(&:text)
    expected_posts = @user.three_most_recent_posts.map(&:title)
    expect(displayed_posts).to match_array(expected_posts)
  end
end
