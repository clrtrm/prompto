# frozen_string_literal: true

json.array! @daily_prompts do |daily_prompt|
  json.date daily_prompt.date
  json.body daily_prompt.body

  today = daily_prompt.date == Date.current
  replied = @replied_daily_prompt_ids.include?(daily_prompt.id)
  json.locked today || !replied
end
