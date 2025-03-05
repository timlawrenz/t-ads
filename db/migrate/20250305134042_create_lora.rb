class CreateLora < ActiveRecord::Migration[8.0]
  def change
    create_table :loras, id: false, primary_key: :id do |t|
      t.string :id, limit: 26, null: false, primary_key: true
      t.string :training_setup_id, null: false, index: true, limit: 26
      t.timestamps
    end

    add_foreign_key :loras, :training_setups, column: :training_setup_id, primary_key: :id
  end
end
