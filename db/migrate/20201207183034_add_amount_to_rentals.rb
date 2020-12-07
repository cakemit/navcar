class AddAmountToRentals < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :amount, :float
  end
end
