class BookingHistory < ApplicationRecord
    belongs_to :service, optional: true
    belongs_to :inventory, optional: true
end
