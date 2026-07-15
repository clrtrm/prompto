# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Prompt, type: :model do
  subject { build(:prompt) }

  it { is_expected.to validate_presence_of(:body) }

  it 'has a valid factory' do
    expect(build(:prompt)).to be_valid
  end
end
