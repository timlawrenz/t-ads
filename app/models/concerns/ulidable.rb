# frozen_string_literal: true

module Ulidable
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    before_create :set_ulid
    friendly_id :extended_ulid

    private

    def set_ulid
      self.id = ULID.generate
    end

    def extended_ulid
      "#{self.class.name.downcase}-#{id}"
    end
  end
end
