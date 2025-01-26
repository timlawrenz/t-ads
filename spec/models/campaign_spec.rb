require 'rails_helper'

RSpec.describe Campaign, type: :model do
  it "creates a ULID on create" do
    campaign = Campaign.create(name: "My Campaign")
    expect(campaign.id).to be_present
  end

  it "creates a friendly_id on create" do
    campaign = Campaign.create(name: "My Campaign")
    expect(campaign.friendly_id).to start_with("campaign-")
  end

  it "validates the presence of a name" do
    campaign = Campaign.create(name: nil)
    expect(campaign.errors[:name]).to include("can't be blank")
  end
end
