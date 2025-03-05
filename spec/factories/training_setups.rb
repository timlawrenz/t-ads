# frozen_string_literal: true

FactoryBot.define do
  factory :training_setup do
    r { 1 }
    learning_rate { 1.5 }
    training_steps { 1 }
    sampler { 'flowmatch' }
    status { 'pending' }
    network_dropout { 0.5 }
  end
end
