# frozen_string_literal: true

class TrainingFilesGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def campaign
    @campaign ||= Campaign.find_by(name:)
    raise 'Campaign not found' unless @campaign

    @campaign
  end

  def target_folder
    @target_folder ||= Rails.public_path.join('training_files', campaign.name)
  end

  def create_target_folder
    empty_directory(target_folder)
  end

  def copy_source_images
    campaign.source_images.each do |image|
      destination_path = target_folder.join(image.filename.to_s)
      write_image_file(destination_path, image)
    end
  end

  def copy_source_image_variants
    Campaign::SOURCE_IMAGE_VARIANTS.each do |variant_name, variant_settings|
      campaign.source_images.each do |image|
        destination_path = target_folder.join("#{variant_name}_#{image.filename}")
        image = image.representation(variant_settings).processed
        write_image_file(destination_path, image)
      end
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
end
