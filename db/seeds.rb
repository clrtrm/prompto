# frozen_string_literal: true

User.create!(
  username: 'admin',
  display_name: 'Prompto Staff',
  email: 'admin@prompto.dev',
  password: 'changeme123!',
  role: :admin
)
