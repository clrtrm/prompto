# frozen_string_literal: true

class DailyPromptsController < ApplicationController
  def index
    daily_prompts = DailyPrompt.includes(:prompt).order(date: :desc)
    render json: daily_prompts.as_json(include: :prompt)
  end

  def today
    daily_prompt = DailyPrompt.includes(:prompt).find_by(date: Date.current)

    if daily_prompt
      render json: daily_prompt.as_json(include: :prompt)
    else
      render json: { error: 'No prompt set for today' }, status: :not_found
    end
  end
end
