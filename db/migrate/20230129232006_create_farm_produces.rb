class CreateFarmProduces < ActiveRecord::Migration[7.0]
  def change
    create_table :farm_produces do |t|
      t.string :name
      t.float :price
      t.integer :stock_level

      t.timestamps
    end
  end
end
