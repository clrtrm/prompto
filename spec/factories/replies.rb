# frozen_string_literal: true

FactoryBot.define do
  factory :reply do
    daily_prompt
    user
    body { "Example reply to today's prompt" }
  end
end
