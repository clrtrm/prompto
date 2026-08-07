# frozen_string_literal: true

json.user do
  json.partial! 'sessions/user', user: @user
end
json.message 'Logged in successfully.'
