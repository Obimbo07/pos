class WorkerDashboardController < ApplicationController
    before_action :authenticate_worker!
    def index
      @current_worker = current_worker
      @services = @current_worker.services
    end
  end
  