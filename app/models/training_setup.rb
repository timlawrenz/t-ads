# frozen_string_literal: true

class TrainingSetup < ApplicationRecord
  include Ulidable

  belongs_to :campaign
  has_many :loras, dependent: :destroy

  validates :r, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :learning_rate, presence: true, numericality: { greater_than: 0 }
  validates :training_steps, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :sampler, presence: true, inclusion: { in: %w[flowmatch] }
  validates :status, presence: true, inclusion: { in: %w[pending running completed failed] }
  validates :network_dropout, presence: true,
                              numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }

  def output_folder
    @output_folder ||= campaign.target_folder.join('output')
  end

  def data_folder
    @data_folder ||= campaign.target_folder.join('data')
  end
end
