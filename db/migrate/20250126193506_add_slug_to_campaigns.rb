class AddSlugToCampaigns < ActiveRecord::Migration[8.0]
  def change
    add_column :campaigns, :slug, :string, null: false
    add_index :campaigns, :slug, unique: true
  end
end
