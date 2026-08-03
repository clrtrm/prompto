# frozen_string_literal: true

json.user do
  if @user
    json.partial! 'sessions/user', user: @user
  else
    json.null!
  end
end
