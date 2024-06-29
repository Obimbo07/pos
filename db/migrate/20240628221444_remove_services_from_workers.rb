class RemoveServicesFromWorkers < ActiveRecord::Migration[7.1]
  def change
    remove_column :workers, :services, :string
  end
end
