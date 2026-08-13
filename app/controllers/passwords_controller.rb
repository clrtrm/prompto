# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  respond_to :json

  def create
    user = User.find_by(email: password_params[:email])
    user&.send_reset_password_instructions

    render json: { message: 'If your username matches an existing account we will send a password reset email within a few minutes. If you have not received an email check your spam folder or contact Support.' }, # rubocop:disable Layout/LineLength
           status: :ok
  end

  def update
    user = User.reset_password_by_token(password_update_params)

    if user.errors.empty?
      render json: { message: 'Password updated successfully.' }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_content
    end
  end

  private

  def password_params
    params.expect(user: [:email])
  end

  def password_update_params
    params.expect(user: %i[reset_password_token password password_confirmation])
  end
end
