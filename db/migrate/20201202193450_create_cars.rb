class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.references :user, null: false, foreign_key: true
      t.string :brand
      t.string :model
      t.integer :year
      t.string :km
      t.float :daily_rate
      t.string :city

      t.timestamps
    end
  end
end
