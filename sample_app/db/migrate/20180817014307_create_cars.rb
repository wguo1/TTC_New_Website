class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
	  t.references :user, foreign_key: true
      t.string :make
      t.string :model
      t.string :year
      t.integer :capacity
      t.string :color
      t.string :license
      t.string :state

      t.timestamps
    end
  end
end
