# frozen_string_literal: true

if @reply
  json.partial! 'replies/reply', reply: @reply
else
  json.null!
end
