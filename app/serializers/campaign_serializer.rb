# frozen_string_literal: true

class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :source_image_urls
end
