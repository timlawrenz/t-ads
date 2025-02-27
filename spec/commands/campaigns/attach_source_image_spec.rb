# frozen_string_literal: true

require 'rails_helper'

module Campaigns
  RSpec.describe AttachSourceImage, type: :command do
    describe '.call' do # Changed from '#call' to '.call'
      let(:campaign) { FactoryBot.create(:campaign) }
      let(:source_image_url) { 'https://example.com/image.jpg' }

      context 'when the image is successfully downloaded and attached' do
        let(:mock_tempfile) do
          mock = double('Tempfile', path: 'path/to/tempfile.jpg')
          allow(mock).to receive_messages(content_type: 'image/jpeg',
                                          original_filename: 'image.jpg')
          mock
        end

        before do
          allow(Down).to receive(:download).with(source_image_url).and_return(mock_tempfile)
          allow(campaign.source_images).to receive(:attach)
        end

        it 'succeeds' do
          result = described_class.call(campaign:, source_image_url:)
          expect(result).to be_success
        end

        it 'attaches the image to the campaign' do
          described_class.call(campaign: campaign, source_image_url: source_image_url) # Changed call
          expect(campaign.source_images).to have_received(:attach)
        end
      end

      context 'when the image download fails' do
        before do
          # Stub Down.download to raise an error
          allow(Down).to receive(:download).with(source_image_url).and_raise(Down::Error,
                                                                             'Download failed')
        end

        it 'fails' do
          result = described_class.call(campaign: campaign, source_image_url: source_image_url) # Changed call
          expect(result).to be_failure
        end

        it 'sets an error message' do
          result = described_class.call(campaign: campaign, source_image_url: source_image_url) # Changed call
          expect(result.error).to be_a(Down::Error)
        end
      end

      context 'when the image attachment fails' do
        let(:mock_tempfile) do
          mock = double('Tempfile', path: 'path/to/tempfile.jpg')
          allow(mock).to receive_messages(content_type: 'image/jpeg',
                                          original_filename: 'image.jpg')
          mock
        end

        before do
          # Stub Down.download to return a mock Tempfile object
          allow(Down).to receive(:download).with(source_image_url).and_return(mock_tempfile)

          # Stub the attach method to raise an error
          allow(campaign.source_images).to receive(:attach).and_raise(StandardError,
                                                                      'Attachment failed')
        end

        it 'fails' do
          result = described_class.call(campaign: campaign, source_image_url: source_image_url)
          expect(result).to be_failure
        end

        it 'sets an error message' do
          result = described_class.call(campaign: campaign, source_image_url: source_image_url)
          expect(result.error).to be_a(StandardError)
        end
      end
    end
  end
end
