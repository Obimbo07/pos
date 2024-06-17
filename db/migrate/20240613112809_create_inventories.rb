class CreateInventories < ActiveRecord::Migration[7.1]
  def change
    create_table :inventories do |t|
      t.string :name
      t.integer :price
      t.boolean :bought
      t.boolean :supplied
      t.integer :in_stock
      t.string :supplier_name
      t.timestamps null: false
    end
  end
end
