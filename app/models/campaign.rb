# frozen_string_literal: true

class Campaign < ApplicationRecord
  include Ulidable

  SOURCE_IMAGE_VARIANT_DEFAULTS = { resize_to_limit: [1024, 1024], format: :jpg }.freeze
  SOURCE_IMAGE_VARIANTS = {
    r2: { rotate: 2 },
    r4: { rotate: 4 },
    r6: { rotate: 6 },
    l2: { rotate: -2 },
    l4: { rotate: -4 },
    l6: { rotate: -6 },
    c10: { crop: [10, 10, 1000, 1000] },
    c20: { crop: [20, 20, 980, 980] },
    r2c10: { rotate: 2, crop: [10, 10, 1000, 1000] },
    r2c20: { rotate: 2, crop: [20, 20, 980, 980] },
    r4c10: { rotate: 4, crop: [10, 10, 1000, 1000] },
    r4c20: { rotate: 4, crop: [20, 20, 980, 980] },
    r6c10: { rotate: 6, crop: [10, 10, 1000, 1000] },
    r6c20: { rotate: 6, crop: [20, 20, 980, 980] },
    l2c10: { rotate: -2, crop: [10, 10, 1000, 1000] },
    l2c20: { rotate: -2, crop: [20, 20, 980, 980] },
    l4c10: { rotate: -4, crop: [10, 10, 1000, 1000] },
    l4c20: { rotate: -4, crop: [20, 20, 980, 980] },
    l6c10: { rotate: -6, crop: [10, 10, 1000, 1000] },
    l6c20: { rotate: -6, crop: [20, 20, 980, 980] }
  }.freeze

  has_many_attached :source_images

  validates :name, presence: true
end
