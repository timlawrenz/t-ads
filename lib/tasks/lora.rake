# frozen_string_literal: true

namespace :lora do
  desc 'move lora to ComfyUI destination folder'
  task :copy_to_comfyui, [:lora_id] => :environment do |_, args|
    lora_id = args[:lora_id]
    lora = Lora.friendly.find(lora_id)
    raise 'Lora not found' unless lora

    lora.copy_to_comfyui
  end

  task :create_samples, [:campaign_id] => :environment do |_, args|
    lora_id = args[:lora_id]
    lora = Lora.friendly.find(lora_id)
    raise 'Lora not found' unless lora

    lora.create_samples
  end
end
