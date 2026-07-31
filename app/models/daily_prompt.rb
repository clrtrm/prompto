# frozen_string_literal: true

class DailyPrompt < ApplicationRecord
  DATE_FORMAT = /\d{4}-\d{2}-\d{2}/

  has_many :replies, dependent: :destroy

  validates :date, presence: true, uniqueness: true
  validates :body, presence: true

  scope :for_today, -> { where(date: Date.current) }

  def reply_from(user)
    replies.find_by(user: user)
  end
end
