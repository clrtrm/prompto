# frozen_string_literal: true

json.id reply.id
json.body reply.body
json.author do
  json.id reply.user.id
  json.displayNameOrUsername reply.user.display_name_or_username
end
