# frozen_string_literal: true

class Campaign < ApplicationRecord
  include Ulidable

  validates :name, presence: true
end
