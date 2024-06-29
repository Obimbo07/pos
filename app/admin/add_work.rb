ActiveAdmin.register_page "Add Work" do
  content do
    panel "Book a Service" do
      render partial: 'admins/bookings/admin_form'
    end
  end

  page_action :create, method: :post do
    booking_history = BookingHistory.new(permitted_params[:booking])

    if booking_history.save
      redirect_to admin_booking_histories_path, notice: "Service booked successfully!"
    else
      redirect_to admin_book_service_path, alert: "Failed to book service. #{booking_history.errors.full_messages.to_sentence}"
    end
  end

  controller do
    def permitted_params
      params.require(:booking_history).permit(:user_name, :phone_number, :is_paid, :payment_method, service_ids: [], inventory_ids: [])
    end
  end
end
