# frozen_string_literal: true

class CreateDailyPrompts < ActiveRecord::Migration[8.1]
  def change
    create_table :daily_prompts do |t|
      t.date :date, null: false
      t.references :prompt, null: false, foreign_key: true

      t.timestamps
    end

    add_index :daily_prompts, :date, unique: true
  end
end
