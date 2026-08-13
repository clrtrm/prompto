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

  def locked_for?(user)
    !revealed? || reply_from(user).nil?
  end

  def revealed?
    date <= self.class.revealed_cutoff_date
  end

  def self.current_cycle_date
    today_10am = Time.current.change(hour: 10)
    Time.current >= today_10am ? Date.current : Date.current - 1
  end

  def self.revealed_cutoff_date
    current_cycle_date - 1
  end
end
