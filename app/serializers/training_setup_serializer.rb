# frozen_string_literal: true

class TrainingSetupSerializer < ActiveModel::Serializer
  attributes :id,
             :r,
             :learning_rate,
             :training_steps,
             :sampler,
             :status,
             :network_dropout

  def lora_config_url
    Rails.application.routes.url_helpers.lora_config_api_v1_campaign_url(object, format: :yaml)
  end
end
