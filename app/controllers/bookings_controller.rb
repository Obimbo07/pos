class BookingsController < ApplicationController
  def index
    @booking_histories = BookingHistory.where(session_id: session[:user_id]).includes(:service, :inventory)
    @phone_number = @booking_histories.map { |booking_history | booking_history.phone_number }
    @total_pay = @booking_histories.sum { |booking_history| (booking_history.service&.price || 0) + (booking_history.inventory&.price || 0) } 
  end

  def new
    @services = params[:service_ids].present? ? Service.where(id: params[:service_ids]) : []
    @inventories = params[:inventory_ids].present? ? Inventory.where(id: params[:inventory_ids]) : []
    @booking_history = BookingHistory.new
  end

  def create
    service_ids = params[:booking][:service_ids].reject(&:blank?)
    inventory_ids = params[:booking][:inventory_ids].reject(&:blank?)


    if service_ids.empty? && inventory_ids.empty?
      redirect_to new_booking_path, alert: "Please select at least one service or inventory item."
    else
      begin
        ActiveRecord::Base.transaction do
          service_ids.each do |service_id|
            BookingHistory.create!(booking_params.merge(service_id: service_id, session_id: session[:user_id]))
          end

          inventory_ids.each do |inventory_id|
            BookingHistory.create!(booking_params.merge(inventory_id: inventory_id, session_id: session[:user_id]))
            inventory = Inventory.find(inventory_id)
            inventory.decrement_stock
          end
        end

        redirect_to home_path, notice: "You have successfully booked a session"
      rescue => e
        redirect_to new_booking_path, alert: "Booking failed: #{e.message}"
      end
    end
  end

  private

  def booking_params
    params.require(:booking_history).permit(:user_name, :phone_number)
  end
end
