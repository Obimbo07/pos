class CreateJoinTableBookingHistoriesWorkers < ActiveRecord::Migration[7.1]
  def change
    create_join_table :booking_histories, :workers do |t|
      t.index :booking_history_id
      t.index :worker_id
    end
  end
end
