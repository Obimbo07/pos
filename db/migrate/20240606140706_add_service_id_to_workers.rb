class AddServiceIdToWorkers < ActiveRecord::Migration[7.1]
  def change
    add_column :workers, :service_id, :integer
  end
end
