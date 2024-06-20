class CreateWorkers < ActiveRecord::Migration[7.1]
  def change
    create_table :workers do |t|
      t.string :name
      t.string :email
      t.integer :phone
      t.string :services

      t.timestamps
    end
  end
end
