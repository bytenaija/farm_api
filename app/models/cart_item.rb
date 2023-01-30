class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :farm_produce

  # Validation
  validates :quantity, numericality: { greater_than: 0 }
end
