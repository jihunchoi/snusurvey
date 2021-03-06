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

ActiveRecord::Schema.define(version: 20131201122754) do

  create_table "answers", force: true do |t|
    t.integer  "type"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "report_id"
    t.integer  "question_id"
    t.integer  "choice_id"
  end

  create_table "choices", force: true do |t|
    t.string   "label"
    t.boolean  "checked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
    t.integer  "next_question_id"
  end

  create_table "questions", force: true do |t|
    t.string   "label"
    t.integer  "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survey_id"
    t.string   "content"
    t.integer  "question_number"
  end

  create_table "reports", force: true do |t|
    t.integer  "survey_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reports", ["survey_id"], name: "index_reports_on_survey_id"
  add_index "reports", ["user_id"], name: "index_reports_on_user_id"

  create_table "surveys", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "editable"
    t.datetime "end_at"
  end

  create_table "users", force: true do |t|
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "memberkey_digest"
    t.integer  "admission_year"
    t.integer  "student_type"
    t.string   "college"
    t.string   "department"
    t.string   "email_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed"
    t.datetime "confirmed_at"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
