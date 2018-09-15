class AddEmergencyNameToUsers < ActiveRecord::Migration[5.2]
  def change
	add_column :users, :emergency_name, :string
  end
end
