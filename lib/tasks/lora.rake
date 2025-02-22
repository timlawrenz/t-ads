# frozen_string_literal: true

namespace :lora do
  desc 'move lora to ComfyUI destination folder'
  task :move, [:campaign_id] => [:environment] do
    campaign_id = args[:campaign_id]
    campaign = Campaign.find(campaign_id)
    raise 'Campaign not found' unless campaign

    Lora.new(campaign).move_to_comfy_ui
  end
end
