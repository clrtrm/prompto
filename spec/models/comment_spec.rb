# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:author).class_name('User') }
  end

  describe 'validations' do
    subject { build(:comment) }

    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_length_of(:body).is_at_least(3) }
    it { is_expected.to validate_length_of(:body).is_at_most(500) }
  end
end
