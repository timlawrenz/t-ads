# frozen_string_literal: true

unless Rails.production?
  class TrainingSetupGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)

    argument :name, type: :string, required: true, desc: 'Campaign name'

    def config_placeholders
      { 'CAMPAIGN_NAME_PLACEHOLDER' => campaign.name,
        'CAMPAIGN_OUTPUT_FOLDER_PLACEHOLDER' => lora.output_folder,
        'CAMPAIGN_DATA_FOLDER_PLACEHOLDER' => lora.data_folder,
        'STEPS_PLACEHOLDER' => lora.steps,
        'LORA_RANK_PLACEHOLDER' => lora.rank,
        'LORA_TRIGGER_PLACEHOLDER' => campaign.description }
    end

    def campaign
      @campaign ||= Campaign.find_by(name:)
      raise 'Campaign not found' unless @campaign

      @campaign
    end

    def lora
      @lora ||= Lora.new(campaign)
    end

    def target_folder
      @target_folder ||= lora.target_folder
    end

    def create_sub_folders
      Lora::TRAINING_SETUP_FOLDERS.each do |folder|
        empty_directory(target_folder.join(folder))
      end
    end

    def copy_source_images
      campaign.source_images.each do |image|
        destination_path = lora.data_folder.join(image.filename.to_s)
        write_image_file(destination_path, image)
      end
    end

    def copy_source_image_variants
      Campaign::SOURCE_IMAGE_VARIANTS.each do |variant_name, variant_settings|
        campaign.source_images.each do |image|
          destination_path = lora.data_folder.join("#{variant_name}_#{image.filename}")
          image = image.representation(variant_settings).processed
          write_image_file(destination_path, image)
        rescue
          puts "Error processing image #{image.filename} with variant #{variant_name}"
          next
        end
      end
    end

    def copy_lora_config
      template 'lora_config.yaml', lora.config_folder.join("#{campaign.name}.yaml")
    end

    def customize_lora_config
      config_placeholders.each do |placeholder, value|
        gsub_file lora.config_file, placeholder, value.to_s
      end
    end

    private

    def write_image_file(destination_path, image)
      create_file(destination_path, image.download)
      write_text_file(destination_path)
    end

    def write_text_file(destination_path)
      text_destination_path = "#{File.dirname(destination_path)}/#{File.basename(destination_path, '.*')}.txt"
      create_file(text_destination_path, campaign.description)
    end
  end
end
