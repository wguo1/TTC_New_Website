class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :featured_trip_id
	  t.text	:comments

      t.timestamps
    end
	add_index :relationships, :follower_id
    add_index :relationships, :featured_trip_id
    add_index :relationships, [:follower_id, :featured_trip_id]
  end
end
