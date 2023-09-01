require 'swagger_helper'

describe 'API V1 Posts', type: :request do
  path '/api/v1/users/{user_id}/posts' do
    get 'Retrieves posts for a user' do
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer

      response '200', 'Posts retrieved' do
        schema type: :array, items: { '$ref' => '#/definitions/Post' }
        run_test!
      end
    end
  end
end
