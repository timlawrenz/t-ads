# frozen_string_literal: true

module Table
  class ThComponent < ViewComponent::Base
    def initialize(title: nil)
      @title = title
    end
  end
end
