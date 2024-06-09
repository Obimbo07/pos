class AddSessionIdToBookingHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :booking_histories, :session_id, :string
  end
end
