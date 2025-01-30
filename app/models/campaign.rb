# frozen_string_literal: true

class Campaign < ApplicationRecord
  include Ulidable

  has_many_attached :source_images

  validates :name, presence: true
end
