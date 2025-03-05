class TrainingSetup < ApplicationRecord
  belongs_to :campaign

  validates :r, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :learning_rate, presence: true, numericality: { greater_than: 0 }
  validates :training_steps, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :sampler, presence: true, inclusion: { in: %w[flowmatch] }
  validates :status, presence: true, inclusion: { in: %w[pending running completed failed] }
  validates :network_dropout, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
end
