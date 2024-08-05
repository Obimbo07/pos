class AddPaidCashOutToWorkerCommissions < ActiveRecord::Migration[7.1]
  def change
    add_column :worker_commissions, :paid_cashout, :boolean, default: false, null: false
  end
end
