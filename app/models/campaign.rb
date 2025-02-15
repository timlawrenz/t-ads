# frozen_string_literal: true

class Campaign < ApplicationRecord
  include Ulidable

  has_many_attached :source_images do |attachable|
    attachable.variant :flipped, flip: :horizontal, preprocessed: true
  end

  validates :name, presence: true
end
