# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150803174222) do

  create_table "employees", force: :cascade do |t|
    t.string   "first_name",                      null: false
    t.string   "last_name",                       null: false
    t.string   "business_email",                  null: false
    t.string   "personal_email",  default: "N/A"
    t.string   "cell_phone",      default: "N/A"
    t.string   "business_phone",                  null: false
    t.string   "extension",       default: "N/A"
    t.string   "home_phone",      default: "N/A"
    t.string   "department",      default: "N/A"
    t.string   "office_number",   default: "N/A"
    t.string   "location",        default: "N/A"
    t.string   "notes"
    t.integer  "manager_id"
    t.string   "password_digest"
    t.string   "salt"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "employees", ["business_email"], name: "index_employees_on_business_email"
  add_index "employees", ["department"], name: "index_employees_on_department"
  add_index "employees", ["first_name"], name: "index_employees_on_first_name"
  add_index "employees", ["last_name"], name: "index_employees_on_last_name"

end
