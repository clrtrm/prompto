# frozen_string_literal: true

module Api
  module V1
    class ApplicationController < ::ApplicationController
      before_action :configure_permitted_parameters, if: :devise_controller?

      protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(
          :sign_up,
          keys: [:username]
        )
      end
    end
  end
end
