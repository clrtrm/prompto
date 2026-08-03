# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe '#confirmation_instructions' do
    let(:user) { create(:user) }
    let(:mail) { described_class.confirmation_instructions(user, 'faketoken', {}) }

    it 'renders the subject' do
      expect(mail.subject).to eq('Confirmation instructions')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'includes the frontend confirmation link' do
      expect(mail.body.encoded).to include('confirm-email?confirmation_token=faketoken')
    end
  end
end
