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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130105021235) do

  create_table "frames", :force => true do |t|
    t.integer  "place_id",                          :null => false
    t.integer  "number",             :default => 0, :null => false
    t.text     "body",                              :null => false
    t.text     "content",                           :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "image",                             :null => false
    t.text     "image_base64",                      :null => false
    t.string   "image_content_type"
    t.integer  "image_size",         :default => 0
    t.string   "image_ext"
  end

  add_index "frames", ["place_id", "number"], :name => "index_frames_on_place_id_and_number", :unique => true

  create_table "places", :force => true do |t|
    t.string   "name",         :limit => 30,                 :null => false
    t.string   "slug",         :limit => 10,                 :null => false
    t.string   "description",  :limit => 200
    t.integer  "frames_count",                :default => 0
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "return_code",  :limit => 10,                 :null => false
    t.string   "title",        :limit => 50
  end

  add_index "places", ["name"], :name => "index_places_on_name", :unique => true
  add_index "places", ["return_code"], :name => "index_places_on_return_code", :unique => true
  add_index "places", ["slug"], :name => "index_places_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
