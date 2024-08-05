ActiveAdmin.register WorkerCommission do
  permit_params :commission, :cashout, :paid_cashout, :worker_id, :booking_history_id

  scope :all, default: true
  scope :cashout_requested do |worker_commissions|
    worker_commissions.where(cashout: true, paid_cashout: false)
  end

  index do
    selectable_column
    id_column
    column :worker
    column :commission
    column :cashout
    column :paid_cashout
    column :created_at
    column :updated_at
    actions defaults: false do |worker_commission|
      if worker_commission.cashout && !worker_commission.paid_cashout
        item "Verify", verify_admin_worker_commission_path(worker_commission), method: :put, class: 'member_link'
      end
      item "View", admin_worker_commission_path(worker_commission)
      item "Edit", edit_admin_worker_commission_path(worker_commission)
      item "Delete", admin_worker_commission_path(worker_commission), method: :delete, data: { confirm: 'Are you sure?' }
    end
  end

  filter :worker
  filter :cashout
  filter :paid_cashout
  filter :created_at
  filter :updated_at

  member_action :verify, method: :put do
    resource.update(paid_cashout: true)
    redirect_to admin_worker_commissions_path, notice: "Cashout request verified successfully."
  end
end
