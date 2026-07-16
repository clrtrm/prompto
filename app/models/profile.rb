# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: true
  validates :bio, length: { maximum: 500 }, allow_nil: true

  delegate :username, :display_name, :display_name_or_username, to: :user
end
