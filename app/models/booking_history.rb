class BookingHistory < ApplicationRecord
    has_and_belongs_to_many :service, optional: true
    belongs_to :inventory, optional: true
    has_many :worker_commissions
    has_and_belongs_to_many :workers

    after_save :calculate_commissions

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "inventory_id", "phone_number", "service_id", "session_id", "updated_at", "user_name", "is_paid", "payment_method"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["inventory", "service", "workers", "worker_commission"]
    end

    private
  
    def calculate_commissions
      workers.each do |worker|
        commission_amount = calculate_commission(service.price, service.commission)
        WorkerCommission.create(worker: worker, booking_history: self, commission: commission_amount, timestamp: Time.current)
      end
    end
  
    def calculate_commission(service_price, commission_rate)
      (service_price * commission_rate / 100.0).round(2)
    end
end
