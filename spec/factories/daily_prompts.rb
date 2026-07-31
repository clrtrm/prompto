# frozen_string_literal: true

FactoryBot.define do
  factory :daily_prompt do
    date { Date.current }
    body { 'How did you choose your school major?' }
  end
end
