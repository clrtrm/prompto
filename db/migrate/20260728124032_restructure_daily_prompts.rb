# frozen_string_literal: true

class RestructureDailyPrompts < ActiveRecord::Migration[8.1]
  def change
    change_table :daily_prompts, bulk: true do |t|
      t.text :body, null: false # rubocop:disable Rails/NotNullColumn
      t.remove :prompt_id, foreign_key: true, type: :bigint
    end
  end
end
