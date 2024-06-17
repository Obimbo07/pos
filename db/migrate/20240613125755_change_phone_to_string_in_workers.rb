class ChangePhoneToStringInWorkers < ActiveRecord::Migration[6.0]
  def change
    change_column :workers, :phone, :string
  end
end
