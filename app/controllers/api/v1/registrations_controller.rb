# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
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
  end
end
