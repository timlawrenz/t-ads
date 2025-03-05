Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :campaigns, only: [:index, :show] do
        resources :training_setups, only: [:index, :show] do
          get :lora_config, on: :member
          resources :loras, only: [:index, :show]
        end
      end
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
