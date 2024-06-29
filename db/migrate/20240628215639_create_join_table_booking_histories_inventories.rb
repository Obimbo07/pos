class CreateJoinTableBookingHistoriesInventories < ActiveRecord::Migration[7.1]
  def change
    create_join_table :booking_histories, :inventories do |t|
      t.index [:booking_history_id, :inventory_id]
      t.index [:inventory_id, :booking_history_id]
    end
  end
end
