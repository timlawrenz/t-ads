class CreateTrainingSetups < ActiveRecord::Migration[8.0]
  def change
    create_table :training_setups, id: false, primary_key: :id do |t|
      t.string :id, limit: 26, null: false, primary_key: true
      t.string :campaign_id, null: false, index: true, limit: 26
      t.integer :r, null: false, default: 16
      t.float :learning_rate, null: false, default: 1e-4
      t.integer :training_steps, null: false, default: 6000
      t.string :sampler, null: false, default: 'flowmatch'
      t.string :status, null: false, default: 'pending'
      t.float :network_dropout, null: false, default: 0.05

      t.timestamps
    end

    add_foreign_key :training_setups, :campaigns, column: :campaign_id, primary_key: :id
  end
end
