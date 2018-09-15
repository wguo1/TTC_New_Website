class AddCapacityToCarpools < ActiveRecord::Migration[5.2]
  def change
	add_column :carpools, :capacity, :integer
  end
end
