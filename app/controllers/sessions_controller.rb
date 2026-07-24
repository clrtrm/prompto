# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!, only: %i[create current] # rubocop:disable Rails/LexicallyScopedActionFilter
  respond_to :json

  def current
    if current_user
      render json: { user: current_user }, status: :ok
    else
      render json: { user: nil }, status: :unauthorized
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: { user: resource, message: 'Logged in successfully.' }, status: :ok
  end

  def respond_to_on_destroy(*)
    if current_user
      render json: { message: 'Logged out successfully.' }, status: :ok
    else
      render json: { message: 'No active session.' }, status: :unauthorized
    end
  end
end
