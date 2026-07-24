# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  skip_before_action :authenticate_user!, only: [:create] # rubocop:disable Rails/LexicallyScopedActionFilter
  respond_to :json

  private

  def sign_up(resource_name, resource); end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        user: resource,
        message: 'Signed up successfully.'
      }, status: :created
    else
      render json: {
        errors: resource.errors.full_messages
      }, status: :unprocessable_content
    end
  end
end
