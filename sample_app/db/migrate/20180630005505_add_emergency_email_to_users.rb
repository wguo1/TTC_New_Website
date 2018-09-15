class AddEmergencyEmailToUsers < ActiveRecord::Migration[5.2]
  def change
	add_column :users, :emergency_email, :string
	add_index(:users, :emergency_email)
  end
end
