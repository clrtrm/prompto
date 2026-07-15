# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', :aggregate_failures, type: :request do # rubocop:disable RSpecRails/InferredSpecType
  let(:correct_password) { 'password123' }
  let(:valid_params) do
    { user: {
      username: 'alice',
      email: 'alice@example.com',
      password: correct_password,
      password_confirmation: correct_password
    } }
  end

  describe 'POST /signup' do
    it 'creates a new user with valid params' do
      post '/signup', params: valid_params
      expect(response).to have_http_status(:created)
      expect(User.count).to eq(1)
    end

    it 'returns errors with invalid params' do
      post '/signup', params: {
        user: { username: '', email: '', password: '' }
      }
      expect(response).to have_http_status(:unprocessable_content)
    end
  end
end
