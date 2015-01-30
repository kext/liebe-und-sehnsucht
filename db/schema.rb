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

ActiveRecord::Schema.define(version: 20150116145926) do

  create_table "boards", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "topic_count"
    t.integer  "post_count"
    t.integer  "last_post_id"
  end

  add_index "boards", ["last_post_id"], name: "index_boards_on_last_post_id"

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["topic_id"], name: "index_posts_on_topic_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.integer  "board_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "post_count"
    t.datetime "first_post_at"
    t.integer  "first_post_user_id"
    t.datetime "last_post_at"
    t.integer  "last_post_user_id"
  end

  add_index "topics", ["board_id"], name: "index_topics_on_board_id"
  add_index "topics", ["first_post_user_id"], name: "index_topics_on_first_post_user_id"
  add_index "topics", ["last_post_user_id"], name: "index_topics_on_last_post_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
