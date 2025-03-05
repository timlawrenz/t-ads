# frozen_string_literal: true

module Api
  module V1
    class TrainingSetupsController < ApplicationController
      def index
        campaign = Campaign.friendly.find(params[:campaign_id])
        render json: campaign.training_setups
      end

      def show
        training_setup = TrainingSetup.friendly.find(params[:id])
        render json: training_setup
      end

      def lora_config
        @campaign = Campaign.friendly.find(params[:campaign_id])
        @training_setup = TrainingSetup.friendly.find(params[:id])
      end
    end
  end
end
