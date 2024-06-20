class BookingHistory < ApplicationRecord
    belongs_to :service, optional: true
    belongs_to :inventory, optional: true
    has_and_belongs_to_many :workers
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "inventory_id", "phone_number", "service_id", "session_id", "updated_at", "user_name"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["inventory", "service", "workers"]
    end
end
