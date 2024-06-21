class CreateWorkerCommissions < ActiveRecord::Migration[7.1]
  def change
    create_table :worker_commissions do |t|
      t.references :worker, null: false, foreign_key: true
      t.references :booking_history, null: false, foreign_key: true
      t.decimal :commission, null: false, default: 0.0
      t.datetime :timestamp, null: false, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
