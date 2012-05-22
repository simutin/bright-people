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

ActiveRecord::Schema.define(:version => 20120522095345) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "activities", :force => true do |t|
    t.string   "title"
    t.string   "address"
    t.text     "description"
    t.integer  "organization_id"
    t.float    "users_rating",                        :default => 0.0, :null => false
    t.float    "experts_rating",                      :default => 0.0, :null => false
    t.point    "location",               :limit => 0,                                  :srid => 4326, :geographic => true
    t.integer  "metro_station_id"
    t.boolean  "is_educational"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.text     "parent_activities"
    t.text     "additional_information"
    t.integer  "age_tag_id"
  end

  create_table "activity_comments", :force => true do |t|
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "commentator"
    t.text     "content"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.boolean  "isParent"
    t.integer  "activity_id"
  end

  create_table "activity_direction_relations", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "direction_tag_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "activity_votes", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "user_id"
    t.integer  "rate"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "admin_users", :force => true do |t|
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

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "age_tags", :force => true do |t|
    t.integer  "start_year"
    t.integer  "end_year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "app_configs", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "direction_tags", :force => true do |t|
    t.string   "name"
    t.boolean  "is_educational"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "experts", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "metro_stations", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "title"
  end

  create_table "organizations", :force => true do |t|
    t.string   "title"
    t.string   "address"
    t.integer  "metro_station_id"
    t.point    "location",         :limit => 0,                 :srid => 4326, :geographic => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teachers", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "name"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "activity_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",               :default => "", :null => false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "facebook_id"
    t.string   "vkontakte_id"
    t.string   "odnoklassniki_id"
    t.integer  "role_id",                             :null => false
    t.string   "encrypted_password"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id"
  add_index "users", ["odnoklassniki_id"], :name => "index_users_on_odnoklassniki_id"
  add_index "users", ["vkontakte_id"], :name => "index_users_on_vkontakte_id"

end
