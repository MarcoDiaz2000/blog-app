require 'swagger_helper'

describe 'API V1 Comments', type: :request do
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    get 'Retrieves comments for a post' do
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :post_id, in: :path, type: :integer

      response '200', 'Comments retrieved' do
        schema type: :array, items: { '$ref' => '#/definitions/Comment' }
        run_test!
      end
    end

    post 'Creates a comment for a post' do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :post_id, in: :path, type: :integer
      parameter name: :comment, in: :body, schema: { '$ref' => '#/definitions/NewComment' }

      response '201', 'Comment created' do
        let(:comment) { { text: 'Amazing Post!' } }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:comment) { { text: '' } }
        run_test!
      end
    end
  end
end
