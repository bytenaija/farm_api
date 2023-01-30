class Cart < ApplicationRecord
  include CartMethods
  belongs_to :user
  has_many :addresses , class_name: 'Address'

  def shipping_address
    addresses.shipping.last
  end

  def billing_address
    addresses.billing.last
  end
end
