# frozen_string_literal: true

class CampaignSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description,
             :source_image_urls,
             :augmented_image_urls,
             :lora_config_url

  def lora_config_url
    Rails.application.routes.url_helpers.lora_config_api_v1_campaign_url(object, format: :yaml)
  end
end
