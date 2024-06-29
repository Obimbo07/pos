class RemoveWorkerIdFromServices < ActiveRecord::Migration[7.1]
  def change
    remove_column :services, :worker_id, :integer
  end
end
