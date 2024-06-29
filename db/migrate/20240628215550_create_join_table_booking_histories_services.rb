class CreateJoinTableBookingHistoriesServices < ActiveRecord::Migration[7.1]
  def change
    create_join_table :booking_histories, :services do |t|
      t.index [:booking_history_id, :service_id]
      t.index [:service_id, :booking_history_id]
    end
  end
end
