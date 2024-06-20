class RemoveServiceIdFromWorkers < ActiveRecord::Migration[7.1]
  def change
    remove_column :workers, :service_id, :integer
  end
end
