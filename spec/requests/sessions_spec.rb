# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do # rubocop:disable RSpecRails/InferredSpecType
  let(:correct_password) { 'password123' }
  let!(:user) { create(:user, password: correct_password) }
  let(:auth_token) do
    post '/login', params: {
      user: { email: user.email, password: correct_password }
    }
    response.headers['Authorization']
  end

  describe 'POST /login' do
    it 'logs in with valid credentials and returns a JWT', :aggregate_failures do
      post '/login', params: {
        user: { email: user.email, password: correct_password }
      }
      expect(response).to have_http_status(:ok)
      expect(response.headers['Authorization']).to be_present
    end

    it 'rejects invalid credentials' do
      post '/login', params: {
        user: { email: user.email, password: 'wrongpassword' }
      }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE /logout' do
    it 'logs out with a valid token' do
      delete '/logout', headers: { 'Authorization' => auth_token }
      expect(response).to have_http_status(:ok)
    end
  end
end
