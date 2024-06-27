class WorkerCommission < ApplicationRecord
  belongs_to :worker
  belongs_to :booking_history

  def self.ransackable_attributes(auth_object = nil)
    ["booking_history_id", "commission", "created_at", "id", "id_value", "timestamp", "updated_at", "worker_id"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["workers", "booking_histories"]
  end
end
