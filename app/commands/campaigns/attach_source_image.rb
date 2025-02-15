# frozen_string_literal: true

module Campaigns
  class AttachSourceImage < GLCommand::Callable
    requires campaign: Campaign,
             source_image_url: String

    def call
      downloaded_file = Down.download(source_image_url)

      campaign.source_images.attach(
        io: downloaded_file,
        filename: File.basename(downloaded_file.path),
        content_type: downloaded_file.content_type
      )
    end
  end
end
