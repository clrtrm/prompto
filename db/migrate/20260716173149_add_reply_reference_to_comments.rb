# frozen_string_literal: true

class AddReplyReferenceToComments < ActiveRecord::Migration[8.1]
  def change
    add_reference :comments, :reply, null: false, foreign_key: true # rubocop:disable Rails/NotNullColumn
  end
end
