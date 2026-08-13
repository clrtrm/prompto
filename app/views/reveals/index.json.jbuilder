# frozen_string_literal: true

json.array! @daily_prompts do |daily_prompt|
  json.date daily_prompt.date
  json.body daily_prompt.body

  cycle_prompt = daily_prompt.date == DailyPrompt.current_cycle_date
  replied = @replied_daily_prompt_ids.include?(daily_prompt.id)
  json.locked cycle_prompt || !replied
end
