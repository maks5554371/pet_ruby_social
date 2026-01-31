# frozen_string_literal: true

class ProfileComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end
end
