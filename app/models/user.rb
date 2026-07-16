# frozen_string_literal: true

class User < ApplicationRecord
  enum :role, { member: 0, admin: 1 }

  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_one :profile, dependent: :destroy

  has_many :replies, dependent: :destroy
  has_many :comments,
           foreign_key: :author_id,
           inverse_of: :author,
           dependent: :destroy
  has_many :daily_prompts, through: :replies

  has_many :following_relationships,
           class_name: 'Follow',
           foreign_key: :follower_id,
           dependent: :destroy

  has_many :following,
           through: :following_relationships,
           source: :followed

  has_many :follower_relationships,
           class_name: 'Follow',
           foreign_key: :followed_id,
           dependent: :destroy

  has_many :followers,
           through: :follower_relationships,
           source: :follower

  after_create :create_profile

  validates :username,
            presence: true,
            uniqueness: true,
            length: { maximum: 30 }
  validates :display_name,
            length: { maximum: 50 },
            allow_nil: true

  def display_name_or_username
    display_name.presence || username
  end

  def follow(user)
    following_relationships.create(followed: user)
  end

  def unfollow(user)
    following_relationships.find_by(followed: user)&.destroy
  end

  def following?(user)
    following.exists?(user)
  end
end
