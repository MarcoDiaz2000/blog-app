require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      user = User.create!(name: 'Name', posts_counter: 0)
      get user_posts_path(user_id: user.id)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end
end
