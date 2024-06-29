class RemoveServiceIdAndInventoryIdFromBookingHistories < ActiveRecord::Migration[7.1]
  def change
    remove_column :booking_histories, :service_id, :integer
    remove_column :booking_histories, :inventory_id, :integer
  end
end
