class BookingHistory < ApplicationRecord
    belongs_to :service, optional: true
    belongs_to :inventory, optional: true
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "inventory_id", "phone_number", "service_id", "session_id", "updated_at", "user_name"]
    end
end
