class CreateJoinTableWorkersServices < ActiveRecord::Migration[7.1]
  def change
    create_join_table :workers, :services do |t|
      t.index [:worker_id, :service_id]
      t.index [:service_id, :worker_id]
    end
  end
end
