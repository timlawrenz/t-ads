class Api::V1::CampaignsController < ApplicationController
  def index
    render json: Campaign.all
  end

  def show
    render json: Campaign.friendly.find(params[:id])
  end
end
