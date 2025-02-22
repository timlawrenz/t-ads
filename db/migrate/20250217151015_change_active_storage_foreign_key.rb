class ChangeActiveStorageForeignKey < ActiveRecord::Migration[8.0]
  def change
    change_column :active_storage_attachments, :record_id, :string, limit: 26, null: false
  end
end
