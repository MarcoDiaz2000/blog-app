require 'rails_helper'
RSpec.feature 'User Posts index page', type: :feature do
  before do
    @user = User.create(name: 'Marco',
                        photo: 'https://image.com/image.jpg', bio: 'Text for Bio', posts_counter: 0)
    @post1 = Post.create(title: 'Post 1', text: 'Text for post...', author: @user, comments_counter: 0,
                         likes_counter: 0)
    @post2 = Post.create(title: 'Post 2', text: 'Text for post...', author: @user, comments_counter: 0,
                         likes_counter: 0)
    @post3 = Post.create(title: 'Post 3', text: 'Text for post...', author: @user, comments_counter: 0,
                         likes_counter: 0)
    @post4 = Post.create(title: 'Post 4', text: 'Text for post...', author: @user, comments_counter: 0,
                         likes_counter: 0)
    @post5 = Post.create(title: 'Post 5', text: 'Text for post...', author: @user, comments_counter: 0,
                         likes_counter: 0)
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
  scenario 'I can see the number of posts the user has written' do
    visit user_posts_path(@user)
    expect(page).to have_content('Number of posts: 5')
  end
  scenario "I can see a post's title" do
    visit user_posts_path(@user)
    expect(page).to have_content('Post 5')
  end
  scenario "I can see some of the post's body" do
    visit user_posts_path(@user)
    expect(page).to have_content('Text for post...')
  end
  scenario 'I can see the first comments on a post' do
    visit user_post_path(@user, @post1)
    expect(page).to have_content('comment 1')
  end
  scenario 'I can see how many comments a post has' do
    visit user_posts_path(@user, @post2)
    expect(page).to have_content('Comments: 0')
  end
  scenario 'I can see how many likes a post has' do
    visit user_posts_path(@user)
    expect(page).to have_content('Likes: 0')
  end
  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(@user)
    expect(page).to have_selector('.pagination')
  end
  scenario "When I click on a post, it redirects me to that post's show page" do
    visit user_posts_path(@user)
    click_link('Post 5')
    expect(page.current_path).to eq(user_post_path(@user, @post5))
  end

  scenario "I can see only the user's three most recent posts" do
    visit user_posts_path(@user)

    displayed_posts = all('.post-row h3').map(&:text)
    expected_posts = @user.three_most_recent_posts.map(&:title)

    expect(displayed_posts).to match_array(expected_posts)
  end

  scenario 'I can see only the five most recent comments for a post' do
    visit user_post_path(@user, @post1)

    displayed_comments = all('.comment .comment-text').map(&:text)
    expected_comments = @post1.five_most_recent_comments.map(&:text)

    expect(displayed_comments).to match_array(expected_comments)
  end
end
