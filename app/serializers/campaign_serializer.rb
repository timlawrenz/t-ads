# frozen_string_literal: true

class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  methods :source_image_urls
end
