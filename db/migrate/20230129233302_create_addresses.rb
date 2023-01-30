class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :address_type
      t.string :line1
      t.string :line2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :country
      t.string :first_name
      t.string :last_name
      t.string :phone_number

      t.timestamps
    end
  end
end
