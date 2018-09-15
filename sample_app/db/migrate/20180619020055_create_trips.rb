class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.text :content, :title, :location, :trip_leaders 
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :trips, [:user_id, :created_at]
  end
end
