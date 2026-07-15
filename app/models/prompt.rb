# frozen_string_literal: true

class Prompt < ApplicationRecord
  validates :body, presence: true, length: { minimum: 10, maximum: 150 }
end
