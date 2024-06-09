class Service < ApplicationRecord
  has_and_belongs_to_many :workers
  has_many :booking_histories
end
