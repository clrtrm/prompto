# frozen_string_literal: true

class RevealsController < ApplicationController
  before_action :set_daily_prompt
  before_action :authorize_reveal!

  def show
    render :show
  end

  private

  def set_daily_prompt
    @daily_prompt = DailyPrompt.find_by(date: params.expect(:date))

    render json: { reason: 'prompt_not_found' }, status: :not_found unless @daily_prompt
  end

  def authorize_reveal!
    return if performed?

    reveal_time = @daily_prompt.date.to_time.change(hour: 10) + 1.day

    if Time.current < reveal_time
      render json: { reason: 'not_yet_revealed' }, status: :forbidden
    elsif @daily_prompt.reply_from(current_user).nil?
      render json: { reason: 'reply_required' }, status: :forbidden
    end
  end
end
