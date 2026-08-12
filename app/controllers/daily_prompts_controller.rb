# frozen_string_literal: true

class DailyPromptsController < ApplicationController
  def index
    @daily_prompts = DailyPrompt.order(:date)
    @daily_prompts = @daily_prompts.where(date: filter_start_date..filter_end_date)
  end

  def today
    @daily_prompt = DailyPrompt.find_by(date: Date.current)

    @daily_prompt ? render(:show) : head(:not_found)
  end

  def show
    @daily_prompt = DailyPrompt.find_by(date: params.expect(:date))

    @daily_prompt ? render(:show) : head(:not_found)
  end

  def update # rubocop:disable Metrics/MethodLength
    @daily_prompt = DailyPrompt.find_or_initialize_by(date: params.expect(:date))
    body = params.fetch(:body).to_s # #fetch over #expect because the latter would invalidate the empty body too soon

    if body.blank?
      @daily_prompt.destroy if @daily_prompt.persisted?
      @status = 'deleted'
    elsif @daily_prompt.update(body: body)
      @status = 'updated'
    else
      @status = 'invalid'
    end

    render :update
  end

  def reply
    @daily_prompt = DailyPrompt.find_by!(date: params.expect(:date))
    @reply = @daily_prompt.reply_from(current_user)

    @reply ? render(:reply) : head(:not_found)
  end

  private

  # If user provided a start date after earliest DailyPrompt, use it, Else, use earliest DailyPrompt.
  def filter_start_date
    user_input = date_params[:start_date].presence
    return DailyPrompt.minimum(:date) if user_input.blank?

    [Date.parse(user_input), DailyPrompt.minimum(:date)].max
  rescue ArgumentError
    DailyPrompt.minimum(:date)
  end

  # If user provided an end date before yesterday, use it. Else, use latest DailyPrompt.
  def filter_end_date
    user_input = date_params[:end_date].presence
    return DailyPrompt.maximum(:date) if user_input.blank?

    Date.parse(user_input)
  rescue ArgumentError
    DailyPrompt.maximum(:date)
  end

  def date_params
    params.permit(:start_date, :end_date)
  end
end
