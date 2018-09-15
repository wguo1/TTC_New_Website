class AddPassengerToRelationship < ActiveRecord::Migration[5.2]
  def change
	add_column :relationships, :passenger, :boolean, default: false
  end
end
