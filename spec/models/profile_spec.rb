# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    subject { create(:profile) }

    it { is_expected.to validate_uniqueness_of(:user_id) }
    it { is_expected.to validate_length_of(:bio).is_at_most(500) }
  end

  describe 'delegation' do
    let(:user) { create(:user, username: 'jdoe', display_name: 'Jane Doe') }
    let(:profile) { user.profile }

    it 'delegates username to the user' do
      expect(profile.username).to eq('jdoe')
    end

    it 'delegates display_name to the user' do
      expect(profile.display_name).to eq('Jane Doe')
    end
  end
end
