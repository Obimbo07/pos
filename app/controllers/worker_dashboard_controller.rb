class WorkerDashboardController < ApplicationController
    # before_action :authenticate_worker!
  
    def index
      service = current_worker.services
    end
  end
  