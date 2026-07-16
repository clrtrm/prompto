# frozen_string_literal: true

class Reply < ApplicationRecord
  belongs_to :daily_prompt
  belongs_to :user

  validates :body, presence: true, length: { minimum: 3, maximum: 500 }
  validates :user_id, uniqueness: { scope: :daily_prompt_id, message: :already_replied }
end
