class Event < ApplicationRecord
  belongs_to :farm_produce
  belongs_to :user
end
