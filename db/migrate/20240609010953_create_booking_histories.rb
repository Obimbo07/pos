class CreateBookingHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :booking_histories do |t|
      t.string :user_name
      t.string :phone_number
      t.integer :service_id

      t.timestamps
    end
  end
end
