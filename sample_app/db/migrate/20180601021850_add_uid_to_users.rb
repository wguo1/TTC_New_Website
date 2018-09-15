class AddUidToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :UID, :integer
  end
end
