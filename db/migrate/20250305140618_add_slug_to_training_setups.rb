class AddSlugToTrainingSetups < ActiveRecord::Migration[8.0]
  def change
    add_column :training_setups, :slug, :string
  end
end
