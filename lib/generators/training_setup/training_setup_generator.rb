# frozen_string_literal: true

class TrainingSetupGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  argument :name, type: :string, required: true, desc: 'Campaign name'

  FOLDERS = %w[data output lora_config].freeze

  def campaign
    @campaign ||= Campaign.find_by(name:)
    raise 'Campaign not found' unless @campaign

    @campaign
  end

  def target_folder
    @target_folder ||= Rails.public_path.join('training_setup', campaign.name)
  end

  FOLDERS.each do |folder|
    define_method(:"#{folder}_folder") do
      target_folder.join(folder)
    end
  end

  def create_sub_folders
    FOLDERS.each do |folder|
      empty_directory(target_folder.join(folder))
    end
  end

  def copy_source_images
    campaign.source_images.each do |image|
      destination_path = data_folder.join(image.filename.to_s)
      write_image_file(destination_path, image)
    end
  end

  def copy_source_image_variants
    Campaign::SOURCE_IMAGE_VARIANTS.each do |variant_name, variant_settings|
      campaign.source_images.each do |image|
        destination_path = data_folder.join("#{variant_name}_#{image.filename}")
        image = image.representation(variant_settings).processed
        write_image_file(destination_path, image)
      end
    end
  end

  def copy_lora_config
    template 'lora_config.yaml', lora_config_folder.join("#{campaign.name}.yaml")
  end

  def customize_lora_config
    placeholders = {
      'CAMPAIGN_NAME_PLACEHOLDER' => campaign.name,
      'CAMPAIGN_OUTPUT_FOLDER_PLACEHOLDER' => output_folder,
      'CAMPAIGN_DATA_FOLDER_PLACEHOLDER' => data_folder,
      'STEPS_PLACEHOLDER' => 500,
      'LORA_RANK_PLACEHOLDER' => 16
    }

    placeholders.each do |placeholder, value|
      gsub_file config_file, placeholder, value.to_s
    end
  end

  private

  def write_image_file(destination_path, image)
    create_file(destination_path, image.download)
    write_text_file(destination_path)
  end

  def write_text_file(destination_path)
    text_destination_path = "#{File.dirname(destination_path)}/#{File.basename(destination_path, '.*')}.txt"
    create_file(text_destination_path, campaign.text)
  end

  def config_file
    @config_file ||= lora_config_folder.join("#{campaign.name}.yaml")
  end
end
