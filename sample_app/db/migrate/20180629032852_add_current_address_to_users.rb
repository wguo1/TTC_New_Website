class AddCurrentAddressToUsers < ActiveRecord::Migration[5.2]
  def change
	add_column :users, :current_address, :text
  end
end
