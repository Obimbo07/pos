class CreateJoinTableBookingHistoriesServices < ActiveRecord::Migration[7.1]
  def change
    create_join_table :booking_histories, :services do |t|
      t.index :booking_history_id
      t.index :service_id
    end
  end
end
