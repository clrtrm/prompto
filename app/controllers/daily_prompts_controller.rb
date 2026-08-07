# frozen_string_literal: true

class DailyPromptsController < ApplicationController
  def index
    render json: DailyPrompt.order(:date)
  end

  def today
    @daily_prompt = DailyPrompt.find_by(date: Date.current)

    @daily_prompt ? render(json: @daily_prompt) : head(:not_found)
  end

  def show
    @daily_prompt = DailyPrompt.find_by(date: params.expect(:date))

    @daily_prompt ? render(json: @daily_prompt) : head(:not_found)
  end

  def update
    @daily_prompt = DailyPrompt.find_or_initialize_by(date: params.expect(:date))

    if @daily_prompt.update(body: params.expect(:body))
      render json: @daily_prompt
    else
      render json: { errors: @daily_prompt.errors.full_messages }, status: :unprocessable_content
    end
  end

  def reply
    @daily_prompt = DailyPrompt.find_by!(date: params.expect(:date))
    @reply = @daily_prompt.reply_from(current_user)

    @reply ? render(:reply) : head(:not_found)
  end
end
