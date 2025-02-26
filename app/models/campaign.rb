# frozen_string_literal: true

class Campaign < ApplicationRecord
  include Ulidable

  SOURCE_IMAGE_VARIANT_DEFAULTS = { resize_to_limit: [1024, 1024], format: :jpg }.freeze
  SOURCE_IMAGE_VARIANTS = {
    rotate_right_by2: { rotate: 2 },
    rotate_right_by4: { rotate: 4 },
    rotate_right_by6: { rotate: 6 },
    rotate_left_by2: { rotate: -2 },
    rotate_left_by4: { rotate: -4 },
    rotate_left_by6: { rotate: -6 },

    crop_by10: { crop: [10, 10, 1000, 1000] },
    crop_by20: { crop: [20, 20, 980, 980] },

    brighten_by20: { add: 20 },
    darken_by20: { subtract: 20 },

    rotate_right_by2_crop_by10: { rotate: 2, crop: [10, 10, 1000, 1000] },
    rotate_right_by2_crop_by20: { rotate: 2, crop: [20, 20, 980, 980] },
    rotate_right_by4_crop_by10: { rotate: 4, crop: [10, 10, 1000, 1000] },
    rotate_right_by4_crop_by20: { rotate: 4, crop: [20, 20, 980, 980] },
    rotate_right_by6_crop_by10: { rotate: 6, crop: [10, 10, 1000, 1000] },
    rotate_right_by6_crop_by20: { rotate: 6, crop: [20, 20, 980, 980] },
    rotate_left_by2_crop_by10: { rotate: -2, crop: [10, 10, 1000, 1000] },
    rotate_left_by2_crop_by20: { rotate: -2, crop: [20, 20, 980, 980] },
    rotate_left_by4_crop_by10: { rotate: -4, crop: [10, 10, 1000, 1000] },
    rotate_left_by4_crop_by20: { rotate: -4, crop: [20, 20, 980, 980] },
    rotate_left_by6_crop_by10: { rotate: -6, crop: [10, 10, 1000, 1000] },
    rotate_left_by6_crop_by20: { rotate: -6, crop: [20, 20, 980, 980] },

    rotate_right_by2_brighten_by20: { rotate: 2, add: 20 },
    rotate_right_by4_brighten_by20: { rotate: 4, add: 20 },
    rotate_right_by6_brighten_by20: { rotate: 6, add: 20 },
    rotate_left_by2_brighten_by20: { rotate: -2, add: 20 },
    rotate_left_by4_brighten_by20: { rotate: -4, add: 20 },
    rotate_left_by6_brighten_by20: { rotate: -6, add: 20 },

    rotate_right_by2_darken_by20: { rotate: 2, subtract: 20 },
    rotate_right_by4_darken_by20: { rotate: 4, subtract: 20 },
    rotate_right_by6_darken_by20: { rotate: 6, subtract: 20 },
    rotate_left_by2_darken_by20: { rotate: -2, subtract: 20 },
    rotate_left_by4_darken_by20: { rotate: -4, subtract: 20 },
    rotate_left_by6_darken_by20: { rotate: -6, subtract: 20 },

    crop_by10_brighten_by20: { crop: [10, 10, 1000, 1000], add: 20 },
    crop_by20_brighten_by20: { crop: [20, 20, 980, 980], add: 20 },

    crop_by10_darken_by20: { crop: [10, 10, 1000, 1000], subtract: 20 },
    crop_by20_darken_by20: { crop: [20, 20, 980, 980], subtract: 20 },

    rotate_right_by2_crop_by10_brighten_by20: { rotate: 2, crop: [10, 10, 1000, 1000], add: 20 },
    rotate_right_by2_crop_by20_brighten_by20: { rotate: 2, crop: [20, 20, 980, 980], add: 20 },
    rotate_right_by4_crop_by10_brighten_by20: { rotate: 4, crop: [10, 10, 1000, 1000], add: 20 },
    rotate_right_by4_crop_by20_brighten_by20: { rotate: 4, crop: [20, 20, 980, 980], add: 20 },
    rotate_right_by6_crop_by10_brighten_by20: { rotate: 6, crop: [10, 10, 1000, 1000], add: 20 },
    rotate_right_by6_crop_by20_brighten_by20: { rotate: 6, crop: [20, 20, 980, 980], add: 20 },
    rotate_left_by2_crop_by10_brighten_by20: { rotate: -2, crop: [10, 10, 1000, 1000], add: 20 },
    rotate_left_by2_crop_by20_brighten_by20: { rotate: -2, crop: [20, 20, 980, 980], add: 20 },
    rotate_left_by4_crop_by10_brighten_by20: { rotate: -4, crop: [10, 10, 1000, 1000], add: 20 },
    rotate_left_by4_crop_by20_brighten_by20: { rotate: -4, crop: [20, 20, 980, 980], add: 20 },
    rotate_left_by6_crop_by10_brighten_by20: { rotate: -6, crop: [10, 10, 1000, 1000], add: 20 },
    rotate_left_by6_crop_by20_brighten_by20: { rotate: -6, crop: [20, 20, 980, 980], add: 20 },

    rotate_right_by2_crop_by10_darken_by20: { rotate: 2, crop: [10, 10, 1000, 1000], subtract: 20 },
    rotate_right_by2_crop_by20_darken_by20: { rotate: 2, crop: [20, 20, 980, 980], subtract: 20 },
    rotate_right_by4_crop_by10_darken_by20: { rotate: 4, crop: [10, 10, 1000, 1000], subtract: 20 },
    rotate_right_by4_crop_by20_darken_by20: { rotate: 4, crop: [20, 20, 980, 980], subtract: 20 },
    rotate_right_by6_crop_by10_darken_by20: { rotate: 6, crop: [10, 10, 1000, 1000], subtract: 20 },
    rotate_right_by6_crop_by20_darken_by20: { rotate: 6, crop: [20, 20, 980, 980], subtract: 20 },
    rotate_left_by2_crop_by10_darken_by20: { rotate: -2, crop: [10, 10, 1000, 1000], subtract: 20 },
    rotate_left_by2_crop_by20_darken_by20: { rotate: -2, crop: [20, 20, 980, 980], subtract: 20 },
    rotate_left_by4_crop_by10_darken_by20: { rotate: -4, crop: [10, 10, 1000, 1000], subtract: 20 },
    rotate_left_by4_crop_by20_darken_by20: { rotate: -4, crop: [20, 20, 980, 980], subtract: 20 },
    rotate_left_by6_crop_by10_darken_by20: { rotate: -6, crop: [10, 10, 1000, 1000], subtract: 20 },
    rotate_left_by6_crop_by20_darken_by20: { rotate: -6, crop: [20, 20, 980, 980], subtract: 20 }
  }.freeze

  has_many_attached :source_images

  validates :name, presence: true

  def source_image_urls
    source_images.map do |source_image|
      Rails.application.routes.url_helpers.rails_representation_url(source_image, host: 'localhost')
    end
  end
end
