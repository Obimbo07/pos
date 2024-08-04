class WorkerDashboardController < ApplicationController
    before_action :authenticate_worker!
    def index
      @current_worker = current_worker
      @services = @current_worker.services
      @worker_commissions = @current_worker.worker_commissions.where(cashout: false)
      @paid_commissions = @current_worker.worker_commissions.where(cashout: true)
      @total_commission = @worker_commissions.sum { |commission| commission.commission || 0}
    end

    def cashout
      @current_worker = current_worker
      commission_ids = params[:worker][:commission_id].first
      @worker_commission = @current_worker.worker_commissions.find(commission_ids)

      # Update the cashout attribute to true
      if @worker_commission.update(cashout: true)
        flash[:notice] = "Cashout request successful."
      else
        flash[:alert] = "Failed to request cashout."
      end
  
      # Redirect or render as necessary
      redirect_to worker_path
    end
  end
