# frozen_string_literal: true

class VersionController < ApplicationController
  def show
    render json: { version: APP_VERSION }
  end
end
