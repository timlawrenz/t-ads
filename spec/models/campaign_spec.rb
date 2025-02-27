# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe 'with a valid factory' do
    subject(:campaign) { FactoryBot.create(:campaign) }

    it 'creates a ULID on create' do
      expect(campaign.id).to be_present
    end

    it 'creates a friendly_id on create' do
      expect(campaign.friendly_id).to start_with('campaign-')
    end
  end

  describe 'with invalid attributes' do
    it 'validates the presence of a name' do
      campaign = described_class.create(name: nil)
      expect(campaign.errors[:name]).to include("can't be blank")
    end
  end

  describe 'source_images' do
    subject(:campaign) { FactoryBot.create(:campaign) }

    it 'can attach a source image' do
      campaign.source_images.attach(io: Rails.root.join('spec/fixtures/image.jpg').open,
                                    filename: 'image.jpg',
                                    content_type: 'image/jpg')
      expect(campaign.source_images).to be_attached
    end
  end

  describe '#source_image_urls' do
    subject(:campaign) { FactoryBot.create(:campaign, :with_images) }

    it 'returns an array of URLs' do
      expect(campaign.source_image_urls).to all(start_with('http'))
    end
  end

  describe '#augmented_image_urls' do
    subject(:campaign) { FactoryBot.create(:campaign, :with_images) }

    it 'returns an array of URLs' do
      expect(campaign.augmented_image_urls).to all(start_with('http'))
    end
  end
end
