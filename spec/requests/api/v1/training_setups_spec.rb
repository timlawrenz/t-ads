# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::TrainingSetup' do
  let(:campaign) { create(:campaign) }
  let(:training_setup) { create(:training_setup, campaign:) }

  describe 'GET /index' do
    it 'returns http success' do
      get "/api/v1/campaigns/#{campaign.id}/training_setups"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/api/v1/campaigns/#{campaign.id}/training_setups/#{training_setup.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /lora_config' do
    it 'returns http success' do
      get "/api/v1/campaigns/#{campaign.id}/training_setups/#{training_setup.id}/lora_config.yaml"
      expect(response).to have_http_status(:success)
    end
  end
end
