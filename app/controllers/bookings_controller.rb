class BookingsController < ApplicationController
  def index
    @booking_histories = BookingHistory.where(session_id: session[:user_id]).includes(:services, :inventories)
    @unique_phone_numbers = @booking_histories.map(&:phone_number).compact.uniq
    @total_pay = @booking_histories.sum do |booking_history| 
      services_total = booking_history.services.sum(&:price)
      inventories_total = booking_history.inventories.sum(&:price)
      services_total + inventories_total 
    end
  end

  def new
    @services = params[:service_ids].present? ? Service.where(id: params[:service_ids]) : []
    @inventories = params[:inventory_ids].present? ? Inventory.where(id: params[:inventory_ids]) : []
    @booking_history = BookingHistory.new
  end

  def create
    service_ids = (params[:booking][:service_ids] || []).reject(&:blank?)
    inventory_ids = (params[:booking][:inventory_ids] || []).reject(&:blank?)

    if service_ids.empty? && inventory_ids.empty?
      redirect_to new_booking_path, alert: "Please select at least one service or inventory item."
    else
      begin
        ActiveRecord::Base.transaction do
          create_bookings_with_items(service_ids, inventory_ids)
        end
        redirect_to home_path, notice: "You have successfully booked a session"
      rescue => e
        redirect_to new_booking_path, alert: "Booking failed: #{e.message}"
      end
    end
  end

  private

  def create_bookings_with_items(service_ids, inventory_ids)
    if service_ids.present?
      service_ids.each do |service_id|
        BookingHistory.create!(booking_params.merge(service_id: service_id, session_id: session[:user_id]))
      end
    end

    if inventory_ids.present?
      inventory_ids.each do |inventory_id|
        BookingHistory.create!(booking_params.merge(inventory_id: inventory_id, session_id: session[:user_id]))
        inventory = Inventory.find(inventory_id)
        inventory.decrement_stock
      end
    end
  end

  def booking_params
    params.require(:booking_history).permit(:user_name, :phone_number, :is_paid, :payment_method, service_ids: [], inventory_ids: [])
  end
end
