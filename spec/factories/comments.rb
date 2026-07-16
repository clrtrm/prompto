# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    author { association :user }
    body { 'A kind and thoughtful comment' }
  end
end
