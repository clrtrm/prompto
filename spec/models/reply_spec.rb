# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reply, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:daily_prompt) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    subject { build(:reply) }

    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(3) }
    it { is_expected.to validate_length_of(:body).is_at_most(500) }

    it {
      expect(subject).to validate_uniqueness_of(:user_id) # rubocop:disable RSpec/NamedSubject
        .scoped_to(:daily_prompt_id)
        .with_message('has already replied to this prompt')
    }
  end
end
