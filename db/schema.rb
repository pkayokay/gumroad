# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_06_195317) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "followers", force: :cascade do |t|
    t.string "email", null: false
    t.bigint "user_id"
    t.bigint "target_user_id", null: false
    t.boolean "is_unsubscribed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_user_id"], name: "index_followers_on_target_user_id"
    t.index ["user_id"], name: "index_followers_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_product_categories_on_category_id"
    t.index ["product_id"], name: "index_product_categories_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "price", default: 0, null: false
    t.string "slug", null: false
    t.boolean "is_published", default: false, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url", null: false
    t.index ["is_published"], name: "index_products_on_is_published"
    t.index ["slug"], name: "index_products_on_slug", unique: true
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "follower_id", null: false
    t.bigint "product_id", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id"], name: "index_purchases_on_follower_id"
    t.index ["product_id"], name: "index_purchases_on_product_id"
    t.index ["user_id", "product_id"], name: "index_purchases_on_user_id_and_product_id", unique: true
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "body"
    t.integer "rating", null: false
    t.bigint "product_id", null: false
    t.bigint "purchase_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_reviews_on_product_id"
    t.index ["purchase_id"], name: "index_reviews_on_purchase_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tips", force: :cascade do |t|
    t.string "email"
    t.string "amount", null: false
    t.bigint "target_user_id", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_user_id"], name: "index_tips_on_target_user_id"
    t.index ["user_id"], name: "index_tips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username", null: false
    t.string "avatar_url", null: false
    t.datetime "last_sign_in_at"
    t.boolean "is_tipping_enabled", default: true, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "followers", "users"
  add_foreign_key "followers", "users", column: "target_user_id"
  add_foreign_key "posts", "users"
  add_foreign_key "product_categories", "categories"
  add_foreign_key "product_categories", "products"
  add_foreign_key "products", "users"
  add_foreign_key "purchases", "followers"
  add_foreign_key "purchases", "products"
  add_foreign_key "purchases", "users"
  add_foreign_key "reviews", "products"
  add_foreign_key "reviews", "purchases"
  add_foreign_key "reviews", "users"
  add_foreign_key "tips", "users"
  add_foreign_key "tips", "users", column: "target_user_id"
end
