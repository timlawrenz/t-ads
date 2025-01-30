# frozen_string_literal: true

module Form
  class InputgroupComponent < ViewComponent::Base
    renders_one :label
    renders_one :input
  end
end
