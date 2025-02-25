class RenameTextToDescriptionInCampaigns < ActiveRecord::Migration[8.0]
  def change
    rename_column :campaigns, :text, :description
  end
end
