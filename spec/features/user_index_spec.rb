require 'rails_helper'

RSpec.feature 'User index page', type: :feature do
  before do
    @user1 = User.create(name: 'Marco',
                         photo: 'https://image.com/image.jpg', bio: 'Text for Bio', posts_counter: 0)

    3.times do |i|
      Post.create(title: "Post #{i + 1}", author: @user1, comments_counter: 0, likes_counter: 0)
    end

    @user2 = User.create(name: 'Tumaini',
                         photo: 'https://www.istockphoto.com/photo.jpg', bio: 'Text for Bio', posts_counter: 0)
  end

  scenario 'I can see the username of all other users' do
    visit users_path

    expect(page).to have_content('Marco')
    expect(page).to have_content('Tumaini')
  end

  scenario 'I can see the profile picture for each user' do
    visit users_path

    expect(page).to have_css("img[src*='#{@user1.photo}']")
    expect(page).to have_css("img[src*='#{@user2.photo}']")
  end

  scenario 'I can see the number of posts each user has written' do
    visit users_path

    expect(page).to have_content('Number of posts: 3')
    expect(page).to have_content('Number of posts: 0')
  end

  scenario "When I click on a user, I am redirected to that user's show page" do
    visit users_path
    find('.user-row-link', text: 'Marco').click

    expect(page.current_path).to eq(user_path(@user1))
  end
end
