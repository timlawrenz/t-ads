# frozen_string_literal: true

class PageheaderComponent < ViewComponent::Base
  renders_one :action

  def initialize(title:)
    @title = title
  end
end
