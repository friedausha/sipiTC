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

ActiveRecord::Schema.define(version: 20180317152453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "computers", force: :cascade do |t|
    t.integer  "laboratory_id",       null: false
    t.string   "spec",                null: false
    t.string   "note"
    t.string   "name",                null: false
    t.date     "reservation_started"
    t.date     "reservation_ended"
    t.integer  "status",              null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["laboratory_id"], name: "index_computers_on_laboratory_id", using: :btree
  end

  create_table "laboratories", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "password",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "user_id",                 null: false
    t.integer  "computer_id",             null: false
    t.string   "reason",                  null: false
    t.integer  "status",      default: 0, null: false
    t.datetime "start_date",              null: false
    t.datetime "end_date",                null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["computer_id"], name: "index_reservations_on_computer_id", using: :btree
    t.index ["user_id"], name: "index_reservations_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "nrp",          null: false
    t.string   "email",        null: false
    t.string   "phone_number", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_foreign_key "computers", "laboratories"
  add_foreign_key "reservations", "computers"
  add_foreign_key "reservations", "users"
end
