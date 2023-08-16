require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates presence of name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
  end

  it 'validates posts_counter is greater than or equal to 0' do
    user = User.new(posts_counter: -1)
    expect(user).to_not be_valid
  end

  it 'returns three most recent posts' do
    user = User.create!(name: 'John', posts_counter: 0)
    3.times.map do
      Post.create!(author: user, title: 'Old post', comments_counter: 0, likes_counter: 0, created_at: 1.day.ago)
    end
    new_posts = 3.times.map { Post.create!(author: user, title: 'New post', comments_counter: 0, likes_counter: 0) }

    expect(user.three_most_recent_posts).to eq new_posts.reverse
  end
end
