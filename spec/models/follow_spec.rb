# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:follower).class_name('User') }
    it { is_expected.to belong_to(:followed).class_name('User') }
  end

  describe 'validations' do
    subject(:follow) { build(:follow) }

    it { is_expected.to validate_uniqueness_of(:follower_id).scoped_to(:followed_id) }
  end

  describe '#cannot_follow_self' do
    it 'is invalid when a user follows themselves', :aggregate_failures do
      user = create(:user)
      follow = build(:follow, follower: user, followed: user)

      expect(follow).not_to be_valid
      expect(follow.errors[:followed]).to include('cannot be yourself')
    end
  end
end
