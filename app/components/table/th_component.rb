# frozen_string_literal: true

class Table::ThComponent < ViewComponent::Base
  def initialize(title: nil)
    @title = title
  end
end
