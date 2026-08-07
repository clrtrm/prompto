# frozen_string_literal: true

json.array! @daily_prompts, partial: 'daily_prompts/daily_prompt', as: :daily_prompt
