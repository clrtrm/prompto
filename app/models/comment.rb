# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :reply

  validates :body, presence: true,
                   length: { minimum: 3, maximum: 500 }
end
