class AddStartdateToTrips < ActiveRecord::Migration[5.2]
  def change
	add_column :trips, :startdate, :datetime
  end
end
