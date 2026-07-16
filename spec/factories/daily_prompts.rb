# frozen_string_literal: true

FactoryBot.define do
  factory :daily_prompt do
    date { Date.current }
    prompt
  end
end
