class CreateCarpools < ActiveRecord::Migration[5.2]
  def change
    create_table :carpools do |t|
	  t.references :user, foreign_key: true
	  t.references :trip, foreign_key: true
      t.timestamps
    end
	
	add_column :carpools, :passengers, :integer, array: true, default: []
	add_index  :carpools, [:user_id, :created_at, :trip_id]
  end
end
