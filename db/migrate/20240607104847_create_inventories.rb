class CreateInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.string :name
      t.integer :price
      t.boolean :bought
      t.boolean :supplied
      t.integer :supplier_name
      t.integer :in_stock

      t.timestamps
    end
  end
end
