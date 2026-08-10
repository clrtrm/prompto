# frozen_string_literal: true

json.status @status

case @status
when 'updated'
  json.dailyPrompt do
    json.partial! 'daily_prompts/daily_prompt', daily_prompt: @daily_prompt
  end
when 'invalid'
  json.errors @daily_prompt.errors.full_messages
end
