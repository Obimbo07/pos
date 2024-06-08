class AddWorkerIdToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :worker_id, :integer
  end
end
