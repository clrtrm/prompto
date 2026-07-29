# frozen_string_literal: true

class RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daily_prompt, only: %i[create]
  before_action :set_reply, only: %i[update]

  def create
    reply = @daily_prompt.replies.new(reply_params.merge(user: current_user))

    if reply.save
      render json: reply, status: :created
    else
      render json: { errors: reply.errors }, status: :unprocessable_content
    end
  end

  def update
    if @reply.update(reply_params)
      render json: @reply
    else
      render json: { errors: @reply.errors }, status: :unprocessable_content
    end
  end

  private

  def set_daily_prompt
    @daily_prompt = DailyPrompt.find_by!(date: params.expect(:daily_prompt_date))
  end

  def set_reply
    @reply = current_user.replies.find(params.expect(:id))
  end

  def reply_params
    params.expect(reply: [:body])
  end
end
