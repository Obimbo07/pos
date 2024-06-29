class Service < ApplicationRecord
  has_and_belongs_to_many :workers
  has_and_belongs_to_many :booking_histories
  def self.ransackable_attributes(auth_object = nil)
    ["commission", "created_at", "id", "id_value", "name", "price", "updated_at", "worker_id"]
  end
  # Ransackable associations
  def self.ransackable_associations(auth_object = nil)
    ["workers", "booking_histories"]
  end
end
