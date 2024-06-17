class CreateWorkers < ActiveRecord::Migration[7.1]
  def change
    create_table :workers do |t|
      t.string :name
      t.string :email
      t.integer :phone
      t.string :services
      t.string :encrypted_password, default: "", null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.timestamps null: false
    end

    add_index :workers, :email, unique: true
    add_index :workers, :reset_password_token, unique: true
  end
end
