# frozen_string_literal: true

class RevealsController < ApplicationController
  before_action :set_daily_prompt, only: %i[show]
  before_action :authorize_reveal!, only: %i[show]

  def index
    cutoff = DailyPrompt.revealed_cutoff_date

    @daily_prompts = DailyPrompt
                     .where('date <= :cutoff OR date = :today', cutoff: cutoff, today: Date.current)
                     .order(date: :desc)

    @replied_daily_prompt_ids = current_user.replies.pluck(:daily_prompt_id).to_set
  end

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

    if !@daily_prompt.revealed?
      render json: { reason: 'not_yet_revealed' }, status: :forbidden
    elsif @daily_prompt.reply_from(current_user).nil?
      render json: { reason: 'reply_required' }, status: :forbidden
    end
  end
end
