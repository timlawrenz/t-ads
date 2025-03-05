# frozen_string_literal: true

unless Rails.env.production?
  class TrainingSetupGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('templates', __dir__)

    URL_BASE = 'https://a1-sarah-a1-3b7b2a76983d.herokuapp.com/api/v1'

    argument :name, type: :string, required: true, desc: 'TrainingSetup ID'

    def create_sub_folders
      TrainingSetup::FOLDERS.each do |folder|
        empty_directory(target_folder.join(folder))
      end
    end

    def copy_source_images
      Parallel.each(campaign_data[:source_image_urls], in_threads: 8) do |image_url|
        download_image(image_url, data_folder)
      end
    end

    def copy_source_image_variants
      Parallel.each(campaign_data[:augmented_image_urls], in_threads: 8) do |image_url|
        download_image(image_url, data_folder)
      end
    end

    def copy_lora_config
      url = "#{campaign_url}/training_setups/#{training_setup[:id]}/lora_config.yaml"
      data = Down.download(url).read
      create_file(config_folder.join('lora_config.yaml'), data)
    end

    private

    def campaign_url
      @campaign_url ||= "#{URL_BASE}/campaigns/#{name}"
    end

    def campaign_data
      if @campaign_data.nil?
        result = Down.download(campaign_url).read
        @campaign_data = JSON.parse(result).with_indifferent_access
      end
      @campaign_data
    end

    def training_setup
      @training_setup ||= @campaign_data[:training_setups].first
    end

    def campaign
      @campaign ||= Campaign.new(name: campaign_data[:name],
                                 description: campaign_data[:description])
    end

    def target_folder
      @target_folder ||= campaign.target_folder
    end

    def data_folder
      @data_folder ||= target_folder.join('data')
    end

    def config_folder
      @config_folder ||= target_folder.join('config')
    end

    def download_image(image_url, destination_path)
      tempfile = Down.download(image_url, extension: 'jpg')
      destination_file_name = "#{destination_path}/#{File.basename(tempfile)}"
      copy_file(tempfile.path, destination_file_name)
      write_text_file(destination_file_name)
    end

    def write_text_file(destination_path)
      text_destination_path = "#{File.dirname(destination_path)}/#{File.basename(destination_path, '.*')}.txt"
      create_file(text_destination_path, campaign.description)
    end
  end
end
