class Mpesa < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["amount", "checkoutRequestID", "created_at", "id", "id_value", "merchantRequestID", "mpesaReceiptNumber", "phoneNumber", "updated_at"]
    end
end
