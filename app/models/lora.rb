# frozen_string_literal: true

class Lora
  TARGET_COMFY_UI_FOLDER = '/mnt/essdee/ComfyUI/models/loras/flux/ads/'
  TRAINING_SETUP_FOLDERS = %w[data output config].freeze

  def initialize(campaign)
    @campaign = campaign
    @campaign_name = campaign.name
  end

  def target_folder
    @target_folder ||= Rails.public_path.join('training_setup', @campaign_name)
  end

  TRAINING_SETUP_FOLDERS.each do |folder|
    define_method(:"#{folder}_folder") do
      target_folder.join(folder)
    end
  end

  def steps
    500
  end

  def rank
    16
  end

  def config_file
    @config_file ||= config_folder.join("#{@campaign_name}.yaml")
  end

  def move_to_comfy_ui
    # FileUtils.cp_r(@campaign.training_setup_folder, TARGET_COMFY_UI_FOLDER)
  end
end
