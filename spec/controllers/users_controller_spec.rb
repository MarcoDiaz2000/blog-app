require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      get users_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include('This is a list of users')
    end
  end

  describe 'GET /show' do
    it 'returns a success response' do
      user = User.create!(name: 'Name', posts_counter: 0)
      get user_path(user)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Here is detail of a specific user')
    end
  end
end
