class AddAddressesToCart < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :cart, null: true, foreign_key: true
  end
end
