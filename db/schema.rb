# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_12_230205) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "booking_histories", force: :cascade do |t|
    t.string "user_name"
    t.string "phone_number"
    t.integer "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_id"
    t.integer "inventory_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.boolean "bought"
    t.boolean "supplied"
    t.integer "in_stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "supplier_name"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.decimal "commission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "worker_id"
  end

  create_table "services_workers", id: false, force: :cascade do |t|
    t.bigint "worker_id", null: false
    t.bigint "service_id", null: false
    t.index ["service_id", "worker_id"], name: "index_services_workers_on_service_id_and_worker_id"
    t.index ["worker_id", "service_id"], name: "index_services_workers_on_worker_id_and_service_id"
  end

  create_table "workers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "phone"
    t.string "services"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_workers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_workers_on_reset_password_token", unique: true
  end

end
