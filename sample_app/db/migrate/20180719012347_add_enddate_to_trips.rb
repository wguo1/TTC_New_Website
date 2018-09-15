class AddEnddateToTrips < ActiveRecord::Migration[5.2]
  def change
	add_column :trips, :enddate, :datetime
  end
end
