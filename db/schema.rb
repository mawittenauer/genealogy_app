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

ActiveRecord::Schema[7.1].define(version: 2024_07_04_154031) do
  create_table "family_trees", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_family_trees_on_user_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "date_of_birth"
    t.date "date_of_death"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "family_tree_id", null: false
    t.string "nickname"
    t.string "birthplace"
    t.text "bio"
    t.string "gender", limit: 1
    t.string "maiden_name"
    t.index ["family_tree_id"], name: "index_people_on_family_tree_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "person_one_id"
    t.integer "person_two_id"
    t.string "relationship_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "family_trees", "users"
  add_foreign_key "people", "family_trees"
end
