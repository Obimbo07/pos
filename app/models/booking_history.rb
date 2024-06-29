class BookingHistory < ApplicationRecord
    has_and_belongs_to_many :services, optional: true
    has_and_belongs_to_many :inventories, optional: true
    has_and_belongs_to_many :workers
    has_many :worker_commissions

    after_save :calculate_commissions

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "inventory_id", "phone_number", "service_id", "session_id", "updated_at", "user_name"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["inventory", "service", "workers", "worker_commission"]
    end

    private
  
    def calculate_commissions
      services.each do |service|
        workers.where(id: service.worker_ids).each do |worker|
          commission_amount = calculate_commission(service.price, service.commission)
          WorkerCommission.create(worker: worker, booking_history: self, commission: commission_amount, timestamp: Time.current)
        end
      end
    end
    
  
    def calculate_commission(service_price, commission_rate)
      (service_price * commission_rate / 100.0).round(2)
    end
end
