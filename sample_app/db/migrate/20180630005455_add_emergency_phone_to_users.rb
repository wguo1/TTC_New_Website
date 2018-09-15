class AddEmergencyPhoneToUsers < ActiveRecord::Migration[5.2]
  def change
	add_column :users, :emergency_phone, :string
  end
end
