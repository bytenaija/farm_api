class AddTotalItemsToCart < ActiveRecord::Migration[7.0]
  def change
    change_table :carts do |t|
      t.decimal :total_amount, precision: 8 
    end
  end
end
