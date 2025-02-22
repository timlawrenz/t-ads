# frozen_string_literal: true

namespace :lora do
  desc 'move lora to ComfyUI destination folder'
  task :copy_to_comfyui, [:campaign_id] => :environment do |_, args|
    campaign_id = args[:campaign_id]
    campaign = Campaign.find_by(name: campaign_id)
    raise 'Campaign not found' unless campaign

    Lora.new(campaign).copy_to_comfyui
  end

  task :create_samples, [:campaign_id] => :environment do |_, args|
    campaign_id = args[:campaign_id]
    campaign = Campaign.find_by(name: campaign_id)
    raise 'Campaign not found' unless campaign

    Lora.new(campaign).create_samples
  end
end
