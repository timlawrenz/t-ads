# frozen_string_literal: true

module Api
  module V1
    class CampaignsController < ApplicationController
      def index
        render json: Campaign.all
      end

      def show
        render json: Campaign.friendly.find(params[:id])
      end
    end
  end
end
