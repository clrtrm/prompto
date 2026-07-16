# frozen_string_literal: true

class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :daily_prompts, through: :replies

  after_create :create_profile

  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  enum :role, { member: 0, admin: 1 }

  validates :username, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :display_name, length: { maximum: 50 }, allow_nil: true

  def display_name_or_username
    display_name.presence || username
  end
end
