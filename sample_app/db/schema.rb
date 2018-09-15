# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_09_02_194122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carpools", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "passengers", default: [], array: true
    t.integer "capacity"
    t.index ["trip_id"], name: "index_carpools_on_trip_id"
    t.index ["user_id", "created_at", "trip_id"], name: "index_carpools_on_user_id_and_created_at_and_trip_id"
    t.index ["user_id"], name: "index_carpools_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.bigint "user_id"
    t.string "make"
    t.string "model"
    t.string "year"
    t.integer "capacity"
    t.string "color"
    t.string "license"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "featured_trip_id"
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accept", default: false
    t.boolean "passenger", default: false
    t.boolean "driver", default: false
    t.index ["featured_trip_id"], name: "index_relationships_on_featured_trip_id"
    t.index ["follower_id", "featured_trip_id"], name: "index_relationships_on_follower_id_and_featured_trip_id"
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "trips", id: :serial, force: :cascade do |t|
    t.text "content"
    t.text "title"
    t.text "location"
    t.text "trip_leaders"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "startdate"
    t.datetime "enddate"
    t.integer "max_capacity"
    t.boolean "active", default: true
    t.index ["user_id", "created_at"], name: "index_trips_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.integer "UID"
    t.string "remember_digest"
    t.integer "admin", default: 0
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.date "birthdate"
    t.string "phone"
    t.text "permanent_address"
    t.text "current_address"
    t.string "emergency_name"
    t.string "emergency_phone"
    t.string "emergency_email"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["emergency_email"], name: "index_users_on_emergency_email"
  end

  add_foreign_key "carpools", "trips"
  add_foreign_key "carpools", "users"
  add_foreign_key "cars", "users"
  add_foreign_key "trips", "users"
end
