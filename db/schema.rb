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

ActiveRecord::Schema.define(version: 2021_04_19_192816) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_games", force: :cascade do |t|
    t.bigint "white_id"
    t.bigint "black_id"
    t.integer "status"
    t.string "starting_fen"
    t.string "current_fen"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "extension"
    t.bigint "next_game_id"
    t.index ["black_id"], name: "index_friendly_games_on_black_id"
    t.index ["next_game_id"], name: "index_friendly_games_on_next_game_id"
    t.index ["white_id"], name: "index_friendly_games_on_white_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_key"
  end

  add_foreign_key "friendly_games", "friendly_games", column: "next_game_id"
  add_foreign_key "friendly_games", "users", column: "black_id"
  add_foreign_key "friendly_games", "users", column: "white_id"
end
