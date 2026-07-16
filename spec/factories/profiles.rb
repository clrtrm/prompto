# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    transient do
      user { create(:user) } # rubocop:disable FactoryBot/FactoryAssociationWithStrategy
    end

    bio { 'Example bio' }

    initialize_with { user.profile }

    after(:build) do |profile, evaluator|
      profile.bio = evaluator.bio
    end
  end
end
