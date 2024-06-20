class AddSupplierNameToInventories < ActiveRecord::Migration[7.1]
  def change
    add_column :inventories, :supplier_name, :string
  end
end
