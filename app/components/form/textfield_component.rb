# frozen_string_literal: true

module Form
  class TextfieldComponent < ViewComponent::Base
    def initialize(form:, field:)
      @form = form
      @field = field
    end
  end
end
