# frozen_string_literal: true

json.id reply.id
json.body reply.body
json.author do
  json.id reply.user.id.to_s
  json.email reply.user.email
  json.username reply.user.username
  json.displayName reply.user.display_name
  json.role reply.user.role
end
