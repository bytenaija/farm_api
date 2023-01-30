class Address < ApplicationRecord
    belongs_to :user
    belongs_to :cart, optional: true


    scope :shipping, -> { where('address_type = ?', 'shipping')}
    scope :billing, -> { where('address_type = ?', 'billing')}
end
