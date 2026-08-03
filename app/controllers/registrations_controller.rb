# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, only: [:create] # rubocop:disable Rails/LexicallyScopedActionFilter
  respond_to :json

  private

  def sign_up(resource_name, resource); end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        message: 'Signed up successfully. Please check your email to confirm your account.',
        user: resource.as_json(only: %i[id email])
      }, status: :created
    else
      render json: {
        errors: resource.errors.full_messages
      }, status: :unprocessable_content
    end
  end
end
