# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Prompts', type: :request do
  describe 'GET /index' do
    context 'when prompts exist' do
      let!(:prompts) { create_list(:prompt, 3) }

      it 'returns a successful response' do
        get '/prompts'
        expect(response).to have_http_status(:ok)
      end

      it 'returns JSON content type' do
        get '/prompts'
        expect(response.content_type).to match(a_string_including('application/json'))
      end

      it 'returns all prompts' do
        get '/prompts'
        expect(response.parsed_body.size).to eq(3)
      end

      it 'returns the correct prompt attributes' do
        get '/prompts'
        expect(response.parsed_body.first).to include(
          'id' => prompts.first.id,
          'body' => prompts.first.body
        )
      end
    end

    context 'when no prompts exist' do
      it 'returns an empty array' do
        get '/prompts'
        expect(response.parsed_body).to eq([])
      end
    end
  end
end
