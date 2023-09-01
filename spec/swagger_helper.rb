require 'rails_helper'

Rswag::Specs.configure do |config|

  config.swagger_root = Rails.root.to_s + '/swagger'
  config.swagger_docs = {
    'v1/swagger.json' => {
      swagger: '2.0',
      info: {
        title: 'API V1',
        version: 'v1'
      },
    }
  }
end
