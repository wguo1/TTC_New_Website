class AddAcceptToRelationships < ActiveRecord::Migration[5.2]
  def change
	add_column :relationships, :accept, :boolean, default: false
  end
end
