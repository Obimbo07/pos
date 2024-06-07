class RemoveSupplierNameFromInventories < ActiveRecord::Migration[7.1]
  def change
    remove_column :inventories, :supplier_name, :integer
  end
end
