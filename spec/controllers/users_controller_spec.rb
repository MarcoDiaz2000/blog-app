require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      get users_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include('This is a list of users')
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it 'returns a success response' do
      user = User.create!(name: 'Name',  photo: 'https://d500.epimg.net/cincodias/imagenes/2016/07/04/lifestyle/1467646262_522853_1467646344_noticia_normal.jpg', posts_counter: 0)
      get user_path(user)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Here is detail of a specific user')
      expect(response).to render_template(:show)
    end
  end
end
