class WorkerDashboardController < ApplicationController
    before_action :authenticate_worker!
    def index
      @current_worker = current_worker
      @services = @current_worker.services
      @worker_commissions = @current_worker.worker_commissions
      @total_commission = @worker_commissions.sum { |commission| commission.commission || 0}
    end
  end
  