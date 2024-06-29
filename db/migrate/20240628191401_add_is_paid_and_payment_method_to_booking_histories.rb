class AddIsPaidAndPaymentMethodToBookingHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :booking_histories, :is_paid, :boolean
    add_column :booking_histories, :payment_method, :string
  end
end
