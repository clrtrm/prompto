# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!, only: %i[create current]
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)
    # auth_options: a private helper method defined in Devise::Controllers::Helpers. It is in scope!
    @user = resource
    render :create, status: :ok
  end

  def current
    @user = current_user
    render :current, status: current_user ? :ok : :unauthorized
  end

  private

  def respond_to_on_destroy(*)
    if current_user
      render json: { message: 'Logged out successfully.' }, status: :ok
    else
      render json: { message: 'No active session.' }, status: :unauthorized
    end
  end
end
