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

ActiveRecord::Schema.define(version: 20131229084415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "dead",       default: false
    t.boolean  "werewolf",   default: false
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "votes",      default: 0
    t.string   "name"
    t.boolean  "voted",      default: false
    t.integer  "score",      default: 0
    t.integer  "max_score",  default: 0
  end

  create_table "events", force: true do |t|
    t.string   "killer"
    t.string   "victim"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "event_type"
  end

  create_table "games", force: true do |t|
    t.boolean  "night",      default: false
    t.boolean  "active",     default: true
    t.integer  "num_alive"
    t.integer  "num_were"
    t.integer  "num_town"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rapns_apps", force: true do |t|
    t.string   "name",                    null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections", default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                    null: false
    t.string   "auth_key"
  end

  create_table "rapns_feedback", force: true do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "app"
  end

  add_index "rapns_feedback", ["device_token"], name: "index_rapns_feedback_on_device_token", using: :btree

  create_table "rapns_notifications", force: true do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.string   "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
  end

  add_index "rapns_notifications", ["app_id", "delivered", "failed", "deliver_after"], name: "index_rapns_notifications_multi", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "registration_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
