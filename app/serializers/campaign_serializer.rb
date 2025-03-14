# frozen_string_literal: true

class CampaignSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description,
             :source_image_urls,
             :augmented_image_urls,
             :training_setups
end
