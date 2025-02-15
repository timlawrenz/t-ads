class AddTextToCampaign < ActiveRecord::Migration[8.0]
  def change
    add_column :campaigns, :text, :text
  end
end
