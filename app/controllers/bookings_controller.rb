class BookingsController < ApplicationController
  def new
    @services = Service.find(params[:service_ids])
    @booking_history = BookingHistory.new
  end

  def create
    service_ids = params[:booking][:service_ids].reject(&:blank?)
    service_ids.each do |service_id|
      BookingHistory.create(booking_params.merge(service_id: service_id))
    end

    redirect_to home_path, notice: "You have successfully booked a session"
  end

  private

  def booking_params
    params.require(:booking_history).permit(:user_name, :phone_number)
  end
end
