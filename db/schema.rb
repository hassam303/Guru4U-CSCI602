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

ActiveRecord::Schema.define(version: 20171029225746) do

  create_table "reports", force: :cascade do |t|
    t.integer "mentee_id"
    t.integer "mentor_id"
    t.string "title"
    t.text "message"
    t.boolean "urgent", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentee_id", "mentor_id"], name: "index_reports_on_mentee_id_and_mentor_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "cwid"
    t.string "email"
    t.string "phone"
    t.string "company"
    t.string "role"
    t.string "advisor"
    t.string "advisor_email"
    t.integer "mentor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cwid", "email"], name: "index_students_on_cwid_and_email", unique: true
    t.index ["mentor_id"], name: "index_students_on_mentor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.boolean "admin", default: false
    t.boolean "force_password_reset", default: false
    t.boolean "disabled", default: false
    t.integer "consecutive_failed_login_attempts", default: 0
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
