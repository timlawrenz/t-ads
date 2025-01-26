# frozen_string_literal: true

class Campaign < ApplicationRecord
  extend FriendlyId
  before_create :set_ulid
  friendly_id :extended_ulid

  validates :name, presence: true

  private

  def set_ulid
    self.id = ULID.generate
  end

  def extended_ulid
    "#{self.class.name.downcase}-#{id}"
  end
end
