class HomeController < ApplicationController
  def index
    @services = Service.all
    @inventories = Inventory.all
    set_sessions
    Rails.logger.info "Session User ID: #{session[:user_id]}"
  end

  def show
    @inventories = Inventory.all
    @services = Service.all
    @workers = Worker.includes(:services)
    @bookings = BookingHistory.all
  end

  private

  def set_sessions
    unless session[:user_id]
      session[:user_id] = SecureRandom.uuid
      flash[:alert] = "Your session has been created"
    end
  end
end
