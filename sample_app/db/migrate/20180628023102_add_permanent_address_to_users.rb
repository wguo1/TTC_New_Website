class AddPermanentAddressToUsers < ActiveRecord::Migration[5.2]
  def change
	add_column :users, :permanent_address, :text
  end
end
