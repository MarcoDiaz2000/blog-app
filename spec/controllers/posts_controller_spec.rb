require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      user = User.create!(name: 'Name', posts_counter: 0)
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end
end
