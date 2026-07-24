# frozen_string_literal: true

module AuthHelper
  def auth_headers_for(user)
    post '/login', params: {
      user: { email: user.email, password: user.password }
    }, as: :json

    token = response.headers['Authorization']
    { 'Authorization' => token }
  end
end

RSpec.configure do |config|
  config.include AuthHelper, type: :request
end
