# frozen_string_literal: true

class CreateReplies < ActiveRecord::Migration[8.1]
  def change
    create_table :replies do |t|
      t.references :daily_prompt, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end

    add_index :replies, %i[daily_prompt_id user_id], unique: true
  end
end
