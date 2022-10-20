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

ActiveRecord::Schema[7.0].define(version: 2022_10_20_195132) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chore_calendar", force: :cascade do |t|
    t.bigint "chore_id"
    t.bigint "user_id"
    t.date "chore_date"
    t.boolean "user_completed", default: false
    t.boolean "checked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chore_id"], name: "index_chore_calendar_on_chore_id"
    t.index ["user_id"], name: "index_chore_calendar_on_user_id"
  end

  create_table "chore_config", force: :cascade do |t|
    t.bigint "chore_id"
    t.integer "schedule_type"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "chore_days"
    t.index ["chore_id"], name: "index_chore_config_on_chore_id"
  end

  create_table "chore_config_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "chore_config_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chore_config_id"], name: "index_chore_config_users_on_chore_config_id"
    t.index ["user_id"], name: "index_chore_config_users_on_user_id"
  end

  create_table "chores", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
