# frozen_string_literal: true

class DailyPromptsController < ApplicationController
  def index
    @daily_prompts = DailyPrompt.order(:date)
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
end
