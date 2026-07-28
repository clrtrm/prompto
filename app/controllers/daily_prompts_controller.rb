# frozen_string_literal: true

class DailyPromptsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: DailyPrompt.order(:date)
  end

  def today
    render json: DailyPrompt.find_by(date: Date.current)
  end

  def show
    daily_prompt = DailyPrompt.find_by(date: params[:date])
    daily_prompt ? render(json: daily_prompt) : head(:not_found)
  end

  def update
    daily_prompt = DailyPrompt.find_or_initialize_by(date: params[:date])

    if daily_prompt.update(body: params[:body])
      render json: daily_prompt
    else
      render json: { errors: daily_prompt.errors.full_messages }, status: :unprocessable_content
    end
  end
end
