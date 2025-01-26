class CreateCampaigns < ActiveRecord::Migration[8.0]
  def change
    create_table :campaigns, id: false, primary_key: :id do |t|
      t.string :id, limit: 26, null: false, primary_key: true
      t.string :name

      t.timestamps
    end
  end
end
