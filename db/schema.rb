# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_15_193602) do

  create_table "authorizations", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_authorizations_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "timeline_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["timeline_id", "name"], name: "index_categories_on_timeline_id_and_name", unique: true
    t.index ["timeline_id"], name: "index_categories_on_timeline_id"
  end

  create_table "categories_events", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "category_id", null: false
    t.index ["category_id"], name: "index_categories_events_on_category_id"
    t.index ["event_id"], name: "index_categories_events_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.date "date"
    t.integer "timeline_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["timeline_id"], name: "index_events_on_timeline_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "user_id", null: false
    t.integer "level", null: false
    t.float "normalized_score"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_ratings_on_category_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "timelines", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "authorizations", "users"
  add_foreign_key "categories", "timelines"
  add_foreign_key "events", "timelines"
  add_foreign_key "ratings", "categories"
  add_foreign_key "ratings", "users"
end
