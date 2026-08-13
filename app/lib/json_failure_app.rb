# frozen_string_literal: true

class JsonFailureApp < Devise::FailureApp
  def respond
    json_error_response
  end

  private

  def json_error_response
    self.status = 401
    self.content_type = 'application/json'
    self.response_body = { errors: [i18n_message] }.to_json
  end
end
