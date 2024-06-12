class HomeController < ApplicationController
  load_and_authorize_resource class: false
  def index
    @services = Service.all
    @inventories = Inventory.all
    set_sessions
    Rails.logger.info "Session User ID: #{session[:user_id]}"
  end

  def show
    @inventories = Inventory.all
    @services = Service.all
  end

  private

  def set_sessions
    unless session[:user_id]
      session[:user_id] = SecureRandom.uuid
      flash[:alert] = "Your session has been created"
    end
  end
end
