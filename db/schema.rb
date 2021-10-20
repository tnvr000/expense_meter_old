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

ActiveRecord::Schema.define(version: 2021_10_20_122159) do

  create_table "customers", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "expenses", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "group_id"
    t.string "title"
    t.float "amount"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_expenses_on_customer_id"
    t.index ["group_id"], name: "index_expenses_on_group_id"
  end

  create_table "groups", charset: "utf8mb4", force: :cascade do |t|
    t.string "customer_email", null: false
    t.string "name"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "memberships", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_memberships_on_customer_id"
    t.index ["group_id"], name: "index_memberships_on_group_id"
  end

  create_table "ownerships", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_ownerships_on_customer_id"
    t.index ["group_id"], name: "index_ownerships_on_group_id"
  end

  create_table "taggings", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "expense_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["expense_id"], name: "index_taggings_on_expense_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_tags_on_customer_id"
  end

  add_foreign_key "expenses", "customers"
  add_foreign_key "expenses", "groups"
  add_foreign_key "memberships", "customers"
  add_foreign_key "memberships", "groups"
  add_foreign_key "ownerships", "customers"
  add_foreign_key "ownerships", "groups"
  add_foreign_key "taggings", "expenses"
  add_foreign_key "taggings", "tags"
  add_foreign_key "tags", "customers"
end
