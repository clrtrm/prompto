# frozen_string_literal: true

class ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :authenticate_user!, raise: false

  def show
    self.resource = resource_class.confirm_by_token(params.expect(:confirmation_token))

    if resource.errors.empty?
      render json: { message: 'Email confirmed successfully.' }, status: :ok
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_content
    end
  end
end
