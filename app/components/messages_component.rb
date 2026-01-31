# frozen_string_literal: true

class MessagesComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end
end
