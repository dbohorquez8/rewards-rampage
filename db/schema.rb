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

ActiveRecord::Schema.define(version: 20161022224106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "participants", force: :cascade do |t|
    t.string   "name"
    t.integer  "reward_page_id"
    t.string   "identifier"
    t.string   "email"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "points"
    t.index ["identifier"], name: "index_participants_on_identifier", using: :btree
    t.index ["reward_page_id"], name: "index_participants_on_reward_page_id", using: :btree
  end

  create_table "reward_pages", force: :cascade do |t|
    t.string   "name"
    t.string   "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_reward_pages_on_identifier", unique: true, using: :btree
  end

  create_table "rewards", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "photo"
    t.integer  "points"
    t.integer  "reward_page_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "status"
    t.integer  "participant_id"
    t.index ["participant_id"], name: "index_rewards_on_participant_id", using: :btree
    t.index ["reward_page_id"], name: "index_rewards_on_reward_page_id", using: :btree
    t.index ["status"], name: "index_rewards_on_status", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.text     "description"
    t.integer  "reward_page_id"
    t.string   "status"
    t.integer  "points"
    t.integer  "participant_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "title"
  end

  add_foreign_key "rewards", "reward_pages"
end
