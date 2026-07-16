# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username) }
  it { is_expected.to validate_presence_of(:email) }

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to have_one(:profile).dependent(:destroy) }
  end

  describe 'profile creation callback' do
    it 'creates a profile automatically after the user is created' do
      user = create(:user)
      expect(user.profile).to be_present
    end
  end
end
