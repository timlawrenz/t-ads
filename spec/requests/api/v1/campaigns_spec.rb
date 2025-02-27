require 'rails_helper'

RSpec.describe 'Api::V1::Campaigns', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/campaigns'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    let(:campaign) { FactoryBot.create(:campaign) }

    it 'returns http success' do
      get "/api/v1/campaigns/#{campaign.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /lora_config' do
    let(:campaign) { FactoryBot.create(:campaign) }

    it 'returns http success' do
      get "/api/v1/campaigns/#{campaign.id}/lora_config.yaml"
      expect(response).to have_http_status(:success)
    end
  end
end
