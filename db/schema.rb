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

ActiveRecord::Schema.define(version: 2019_02_20_160246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_genres", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artist_tracks", force: :cascade do |t|
    t.integer "artist_id"
    t.integer "track_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "spotify_url"
    t.string "href"
    t.string "spotify_id"
    t.string "uri"
    t.string "img_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name"
    t.string "spotify_url"
    t.string "href"
    t.string "spotify_id"
    t.string "preview_url"
    t.string "uri"
    t.string "spotify_artist_id"
    t.integer "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_artists", force: :cascade do |t|
    t.integer "user_id"
    t.integer "artist_id"
    t.integer "popularity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_tracks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "track_id"
    t.integer "popularity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "access_token"
    t.string "refresh_token"
    t.string "spotify_url"
    t.string "profile_img_url"
    t.string "href"
    t.string "uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
