# frozen_string_literal: true

module Api
  module V1
    class CampaignsController < ApplicationController
      def index
        render json: Campaign.all.map(&:serializable_hash)
      end

      def show
        render json: Campaign.friendly.find(params[:id]).serializable_hash(methods: :source_image_urls)
      end
    end
  end
end
