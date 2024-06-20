class WorkerCommission < ApplicationRecord
  belongs_to :worker
  belongs_to :booking_history
end
