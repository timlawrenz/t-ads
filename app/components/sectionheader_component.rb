# frozen_string_literal: true

class SectionheaderComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end
end
