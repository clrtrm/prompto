# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reveals', type: :request do
  describe 'GET /reveals/:date' do
    let(:user) { create(:user) }
    let(:daily_prompt) { create(:daily_prompt, date: Date.new(2026, 7, 31)) }
    let(:reveal_time) { Time.zone.local(2026, 8, 1, 10, 0, 0) }

    context 'when unauthenticated' do
      it 'returns unauthorized' do
        get "/reveals/#{daily_prompt.date}", as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when the reveal time has not been reached yet' do
      it 'returns forbidden just before the cutoff' do
        travel_to(reveal_time - 1.second) do
          get "/reveals/#{daily_prompt.date}", headers: auth_headers_for(user), as: :json
        end

        expect(response).to have_http_status(:forbidden)
      end

      it 'returns a not_yet_revealed reason just before the cutoff' do
        travel_to(reveal_time - 1.second) do
          get "/reveals/#{daily_prompt.date}", headers: auth_headers_for(user), as: :json
        end

        expect(response.parsed_body['reason']).to eq('not_yet_revealed')
      end

      it 'returns forbidden earlier the same day the prompt was posted' do
        travel_to(daily_prompt.date.to_time.change(hour: 15)) do
          get "/reveals/#{daily_prompt.date}", headers: auth_headers_for(user), as: :json
        end

        expect(response).to have_http_status(:forbidden)
      end
    end

    context 'when the reveal time has been reached and the user has not replied' do
      it 'returns forbidden' do
        travel_to(reveal_time) do
          get "/reveals/#{daily_prompt.date}", headers: auth_headers_for(user), as: :json
        end

        expect(response).to have_http_status(:forbidden)
      end

      it 'returns a reply_required reason' do
        travel_to(reveal_time) do
          get "/reveals/#{daily_prompt.date}", headers: auth_headers_for(user), as: :json
        end

        expect(response.parsed_body['reason']).to eq('reply_required')
      end
    end

    context 'when the reveal time has been reached and the user has replied' do
      before { create(:reply, daily_prompt: daily_prompt, user: user) }

      it 'returns a successful response' do
        travel_to(reveal_time) do
          get "/reveals/#{daily_prompt.date}", headers: auth_headers_for(user), as: :json
        end

        expect(response).to have_http_status(:ok)
      end

      it 'returns the daily prompt id' do
        travel_to(reveal_time) do
          get "/reveals/#{daily_prompt.date}", headers: auth_headers_for(user), as: :json
        end

        expect(response.parsed_body['id']).to eq(daily_prompt.id)
      end

      it 'includes the replies' do
        travel_to(reveal_time) do
          get "/reveals/#{daily_prompt.date}", headers: auth_headers_for(user), as: :json
        end

        expect(response.parsed_body['replies'].size).to eq(1)
      end
    end

    context 'when no daily prompt exists for the date' do
      it 'returns not_found' do
        get '/reveals/2099-01-01', headers: auth_headers_for(user), as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
