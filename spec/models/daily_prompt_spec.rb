# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyPrompt, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:prompt) }
    it { is_expected.to have_many(:replies).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build(:daily_prompt) }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_uniqueness_of(:date) }
  end

  describe '.for_today' do
    it 'returns the daily prompt scheduled for today' do
      todays_prompt = create(:daily_prompt, date: Date.current)
      create(:daily_prompt, date: Date.yesterday)

      expect(described_class.for_today).to contain_exactly(todays_prompt)
    end
  end
end
