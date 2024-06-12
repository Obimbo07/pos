class BookingHistory < ApplicationRecord
    belongs_to :service
    belongs_to :inventory
end
