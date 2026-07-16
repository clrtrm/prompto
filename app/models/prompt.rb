# frozen_string_literal: true

class Prompt < ApplicationRecord
  has_many :daily_prompts, dependent: :restrict_with_error

  validates :body, presence: true, length: { minimum: 10, maximum: 150 }
end
