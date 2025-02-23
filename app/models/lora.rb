# frozen_string_literal: true

class Lora
  TRAINING_SETUP_FOLDERS = %w[data output config].freeze

  TARGET_COMFYUI_FOLDER = '/mnt/essdee/ComfyUI/models/loras/flux/ads/'
  COMFYUI_WORKFLOW_TEMPLATE = Rails.root.join('lib', 'tasks', 'comfyui_workflow_template.json')
  COMFYUI_URL = 'http://localhost:8188/prompt'

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
    3000
  end

  def rank
    16
  end

  def config_file
    @config_file ||= config_folder.join("#{@campaign_name}.yaml")
  end

  def lora_files
    @lora_files ||= output_folder.join(@campaign_name).glob('*.safetensors')
  end

  def copy_to_comfyui
    lora_files.each do |lora_file|
      FileUtils.cp(lora_file, TARGET_COMFYUI_FOLDER)
    end
  end

  def create_samples
    client_id = SecureRandom.uuid_v4
    prompt = JSON.parse(COMFYUI_WORKFLOW_TEMPLATE.read)
    prompt['82']['inputs']['text'] = "A young woman wearing a #{@campaign.text}."
    prompt['83']['inputs']['lora_1']['lora'] = @campaign_name
    prompt['85']['inputs']['filename_prefix'] = "ads/loras/samples/#{@campaign_name}/sample"
    data = { client_id:, prompt: }

    uri = URI(COMFYUI_URL)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = data.to_json
    http = Net::HTTP.new(uri.host, uri.port)
    http.request(request)
  end
end
