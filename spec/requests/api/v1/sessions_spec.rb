# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Sessions', type: :request do
  let(:correct_password) { 'password123' }
  let!(:user) { create(:user, password: correct_password) }
  let(:auth_token) do
    post '/api/v1/login', params: {
      user: { email: user.email, password: correct_password }
    }
    response.headers['Authorization']
  end

  describe 'POST /api/v1/login' do
    it 'logs in with valid credentials and returns a JWT', :aggregate_failures do
      post '/api/v1/login', params: {
        user: { email: user.email, password: correct_password }
      }
      expect(response).to have_http_status(:ok)
      expect(response.headers['Authorization']).to be_present
    end

    it 'rejects invalid credentials' do
      post '/api/v1/login', params: {
        user: { email: user.email, password: 'wrongpassword' }
      }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE /api/v1/logout' do
    it 'logs out with a valid token' do
      delete '/logout', headers: { 'Authorization' => auth_token }
      expect(response).to have_http_status(:ok)
    end
  end
end
