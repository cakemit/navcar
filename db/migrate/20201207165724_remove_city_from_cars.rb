class RemoveCityFromCars < ActiveRecord::Migration[6.0]
  def change
    remove_column :cars, :city, :string
  end
end
