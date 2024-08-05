class AddCashOutToWorkerCommissions < ActiveRecord::Migration[7.1]
  def change
    add_column :worker_commissions, :cashout, :boolean, null: false, default: false
  end
end
