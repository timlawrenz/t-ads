# frozen_string_literal: true

module Ulidable
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    before_create :set_ulid
    friendly_id :slug, use: :slugged

    private

    def set_ulid
      self.id ||= ULID.generate
      self.slug ||= "#{self.class.name.downcase}-#{id}"
    end
  end
end
