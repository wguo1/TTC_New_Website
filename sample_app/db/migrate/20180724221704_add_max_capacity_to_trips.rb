class AddMaxCapacityToTrips < ActiveRecord::Migration[5.2]
  def change
	add_column :trips, :max_capacity, :integer
  end
end
