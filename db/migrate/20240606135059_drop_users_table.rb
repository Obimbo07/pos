class DropUsersTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :users
  end

  def down
    # You can recreate the table structure here if you want to be able to rollback this migration
    create_table :users do |t|
      t.string :email, default: "", null: false
      t.string :encrypted_password, default: "", null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer :failed_attempts, default: 0, null: false
      t.string :unlock_token
      t.datetime :locked_at
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      
      t.index :email, unique: true
      t.index :reset_password_token, unique: true
    end
  end
end
