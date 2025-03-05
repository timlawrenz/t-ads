# frozen_string_literal: true

class Lora < ApplicationRecord
  TARGET_COMFYUI_FOLDER = '/mnt/essdee/ComfyUI/models/loras/flux/ads/'
  COMFYUI_WORKFLOW_TEMPLATE = Rails.root.join('lib/tasks/comfyui_workflow_template.json')
  COMFYUI_URL = 'http://localhost:8188/prompt'

  belongs_to :training_setup
  has_one :campaign, through: :training_setup

  def target_folder
    @target_folder ||= Rails.public_path.join('training_setup', campaign.name)
  end

  TrainingSetup::FOLDERS.each do |folder|
    define_method(:"#{folder}_folder") do
      target_folder.join(folder)
    end
  end

  def steps
    6000
  end

  def rank
    16
  end

  def config_file
    @config_file ||= config_folder.join("#{campaign.name}.yaml")
  end

  def lora_files
    output_folder.join(campaign.name).glob('*.safetensors')
  end

  def copy_to_comfyui
    lora_files.each do |lora_file|
      FileUtils.cp(lora_file, TARGET_COMFYUI_FOLDER)
    end
  end

  def prompts
    postfix = 'Busty, slim, small frame, petite, sarah1a3, very small waist, long neck, smooth torso, flat tummy, full HD, cinematic'
    locations = [
      'at the beach with her body turned to the side',
      'on the porch of a modern beach villa',
      'in the living room of a modern beach villa',
      ''
    ]
    activities = [
      'standing',
      'sitting',
      'lounging',
      'throwing a pose for a photo like a model',
      ''
    ]
    locations.map do |location|
      activities.map do |activity|
        "The image is a portrait of a young woman with long brunette hair. She is #{activity} #{location}. The woman is wearing #{@campaign.description}. The light is soft, it's golden hour. #{postfix}"
      end
    end.flatten
  end

  def create_samples
    client_id = SecureRandom.uuid_v4

    template = JSON.parse(COMFYUI_WORKFLOW_TEMPLATE.read)

    lora_files.each do |lora_file|
      lora_name = File.basename(lora_file, '.safetensors')
      template['83']['inputs']['lora_2']['lora'] = lora_name

      prompts.each_with_index do |prompt, index|
        template['85']['inputs']['filename_prefix'] =
          "ads/loras/samples/#{campaign.name}/#{DateTime.now.to_date.to_fs}/#{lora_name}/prompt_#{index}"
        template['82']['inputs']['text'] = prompt
        data = { client_id:, prompt: template }
        Rails.logger.debug { "prompt #{index}: #{prompt}" }
        send_sample_request(data)
      end
    end
  end

  def send_sample_request(data)
    uri = URI(COMFYUI_URL)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = data.to_json
    http = Net::HTTP.new(uri.host, uri.port)
    http.request(request)
  end
end
