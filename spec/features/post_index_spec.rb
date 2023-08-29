require 'rails_helper'

RSpec.feature "User Posts index page", type: :feature do
  before do
    @user = User.create(name: "Marco", photo: 'https://...', bio: 'Text for Bio', posts_counter: 0)
  
    5.times do |i|
      Post.create(title: "Post #{i+1}", author: @user, comments_counter: 0, likes_counter: 0)
    end
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
    expect(page).to have_content("Post 1")
  end

  scenario "I can see some of the post's body" do
    visit user_posts_path(@user)
    # Asumiendo que 'truncate' está configurado para cortar a 50 caracteres
    expect(page).to have_content(truncate("El texto del post...", length: 50))
  end

  # Agrega más pruebas para los comentarios, los likes, la paginación, etc.
end
