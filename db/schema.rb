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

ActiveRecord::Schema.define(:version => 20120104233453) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bank_transfer_details", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cartitems", :force => true do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "amount",     :default => 0, :null => false
  end

  add_index "cartitems", ["order_id"], :name => "index_cartitems_on_order_id"
  add_index "cartitems", ["product_id"], :name => "index_cartitems_on_product_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["category_id"], :name => "index_categories_on_category_id"

  create_table "messages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "email"
    t.string   "phone"
    t.string   "instructions"
    t.boolean  "completed",    :default => false
    t.boolean  "shipped",      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "paid",         :default => false
    t.string   "source"
  end

  create_table "photos", :force => true do |t|
    t.integer  "product_id"
    t.string   "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "sku"
    t.integer  "category_id"
    t.integer  "badge_id"
    t.string   "short_description"
    t.string   "long_description"
    t.integer  "discount",          :default => 0
    t.float    "price",             :default => 0.0
    t.integer  "stock",             :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["badge_id"], :name => "index_products_on_badge_id"
  add_index "products", ["category_id"], :name => "index_products_on_category_id"
  add_index "products", ["sku"], :name => "index_products_on_sku"

  create_table "settings", :force => true do |t|
    t.float "shipping_cost",           :default => 5.0
    t.float "free_shipping_threshold", :default => 50.0
  end

end
