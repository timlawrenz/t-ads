# frozen_string_literal: true

module Form
  class LabelComponent < ViewComponent::Base
    def initialize(form:, for_id:)
      @form = form
      @for_id = for_id
    end
  end
end
