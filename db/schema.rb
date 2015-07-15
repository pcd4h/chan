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

ActiveRecord::Schema.define(version: 20150715080307) do

  create_table "enum_values", force: true do |t|
    t.string   "enumvalid"
    t.string   "name"
    t.integer  "form_property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enum_values", ["form_property_id"], name: "index_enum_values_on_form_property_id"

  create_table "form_properties", force: true do |t|
    t.string   "formpropid"
    t.string   "name"
    t.string   "formproptype"
    t.text     "value"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "processed",    default: false
  end

  add_index "form_properties", ["task_id"], name: "index_form_properties_on_task_id"

  create_table "tasks", force: true do |t|
    t.string   "taskid"
    t.string   "url"
    t.string   "assignee"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "processed",   default: false
    t.boolean  "in_progress", default: false
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "api_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "v_messages", force: true do |t|
    t.string   "message_id"
    t.string   "in_reply_to"
    t.text     "content"
    t.string   "session_event"
    t.string   "to_addr"
    t.string   "to_addr_type"
    t.string   "from_addr"
    t.string   "from_addr_type"
    t.string   "transport_name"
    t.string   "transport_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "direction"
  end

end
