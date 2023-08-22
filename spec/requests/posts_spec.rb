require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      user = User.create!(name: 'Name', posts_counter: 0)
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      user = User.create!(name: 'Name', posts_counter: 0)
      post = user.posts.create!(title: 'Título del post', comments_counter: 0, likes_counter: 0)
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
