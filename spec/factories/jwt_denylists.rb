# frozen_string_literal: true

FactoryBot.define do
  factory :jwt_denylist do
    jti { 'MyString' }
    exp { '2026-07-08 19:06:04' }
  end
end
