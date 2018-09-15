class AddDriverToRelationship < ActiveRecord::Migration[5.2]
  def change
	add_column :relationships, :driver, :boolean, default: false
  end
end
