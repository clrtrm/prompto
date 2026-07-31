# frozen_string_literal: true

json.id @daily_prompt.id
json.date @daily_prompt.date
json.body @daily_prompt.body
json.replies @daily_prompt.replies.includes(:user) do |reply|
  json.partial! 'replies/reply', reply: reply
end
