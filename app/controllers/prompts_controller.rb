# frozen_string_literal: true

class PromptsController < ApplicationController
  def index
    @prompts = Prompt.all
  end
end
