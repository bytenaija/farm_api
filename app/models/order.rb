class Order < ApplicationRecord
  belongs_to :user
  has_many :addresses , class_name: 'Address'

  scope :shipping_address, -> { joins(:addresses).where('addresses.address_type = ?', 'shipping')}
  scope :billing_address, -> { joins(:addresses).where('addresses.address_type = ?', 'billing')}
end
