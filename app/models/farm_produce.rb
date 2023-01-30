class FarmProduce < ApplicationRecord
  # Association with other models
  has_many :cart_items
  has_many :order_items
end
