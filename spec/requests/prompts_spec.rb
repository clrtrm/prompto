# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Prompts', type: :request do
  describe 'GET /index' do
    let(:user) { create(:user) }

    context 'when unauthenticated' do
      it 'returns unauthorized' do
        get '/prompts', as: :json
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns a JSON error body', :aggregate_failures do
        get '/prompts', as: :json
        expect(response.parsed_body).to include('errors')
        expect(response.parsed_body['errors']).to be_an(Array)
        expect(response.parsed_body['errors']).not_to be_empty
      end
    end

    context 'when authenticated and prompts exist' do
      let!(:prompts) { create_list(:prompt, 3) }

      it 'returns a successful response' do
        get '/prompts', headers: auth_headers_for(user), as: :json
        expect(response).to have_http_status(:ok)
      end

      it 'returns JSON content type' do
        get '/prompts', headers: auth_headers_for(user), as: :json
        expect(response.content_type).to match(a_string_including('application/json'))
      end

      it 'returns all prompts' do
        get '/prompts', headers: auth_headers_for(user), as: :json
        expect(response.parsed_body.size).to eq(3)
      end

      it 'returns the correct prompt attributes' do
        get '/prompts', headers: auth_headers_for(user), as: :json
        expect(response.parsed_body.first).to include(
          'id' => prompts.first.id,
          'body' => prompts.first.body
        )
      end
    end

    context 'when authenticated and no prompts exist' do
      it 'returns an empty array' do
        get '/prompts', headers: auth_headers_for(user), as: :json
        expect(response.parsed_body).to eq([])
      end
    end
  end
end
