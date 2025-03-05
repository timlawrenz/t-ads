# frozen_string_literal: true

class TrainingSetup < ApplicationRecord
  include Ulidable

  FOLDERS = %w[data output config].freeze

  belongs_to :campaign
  has_many :loras, dependent: :destroy

  validates :r, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :learning_rate, presence: true, numericality: { greater_than: 0 }
  validates :training_steps, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :sampler, presence: true, inclusion: { in: %w[flowmatch] }
  validates :status, presence: true, inclusion: { in: %w[pending running completed failed] }
  validates :network_dropout, presence: true,
                              numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }

  def target_folder
    @target_folder ||= campaign.target_folder.join(slug)
  end

  FOLDERS.each do |folder|
    define_method(:"#{folder}_folder") do
      target_folder.join(folder)
    end
  end
end
