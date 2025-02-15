# frozen_string_literal: true

class Campaign < ApplicationRecord
  include Ulidable

  SOURCE_IMAGE_VARIANTS = { flipped: { flip: :horizontal } }.freeze

  has_many_attached :source_images do |attachable|
    SOURCE_IMAGE_VARIANTS.each do |variant_name, variant_settings|
      attachable.variant variant_name, variant_settings
    end
  end

  validates :name, presence: true
end
