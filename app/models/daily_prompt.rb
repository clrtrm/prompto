# frozen_string_literal: true

class DailyPrompt < ApplicationRecord
  belongs_to :prompt
  has_many :replies, dependent: :destroy

  validates :date, presence: true, uniqueness: true

  scope :for_today, -> { where(date: Date.current) }
end
