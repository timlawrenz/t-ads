# frozen_string_literal: true

class Campaign < ApplicationRecord
  include Ulidable

  SOURCE_IMAGE_VARIANT_DEFAULTS = { resize_to_limit: [1024, 1024] }.freeze
  SOURCE_IMAGE_VARIANTS = {
    flipped: { flip: :horizontal },
    r10: { rotate: 10 },
    l10: { rotate: -10 },
    flipped_r10: { flip: :horizontal, rotate: 10 },
    flipped_l10: { flip: :horizontal, rotate: -10 }
  }.freeze

  has_many_attached :source_images do |attachable|
    SOURCE_IMAGE_VARIANTS.each do |variant_name, variant_settings|
      attachable.variant variant_name, SOURCE_IMAGE_VARIANT_DEFAULTS.merge(variant_settings)
    end
  end

  validates :name, presence: true
end
