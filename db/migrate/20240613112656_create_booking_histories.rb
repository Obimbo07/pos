class CreateBookingHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :booking_histories do |t|
      t.string :user_name
      t.string :phone_number
      t.integer :service_id
      t.string :session_id
      t.integer :inventory_id
      t.timestamps null: false
    end
  end
end
