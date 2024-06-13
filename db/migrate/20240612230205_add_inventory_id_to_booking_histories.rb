class AddInventoryIdToBookingHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :booking_histories, :inventory_id, :integer
  end
end
