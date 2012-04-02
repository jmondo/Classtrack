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

ActiveRecord::Schema.define(:version => 20120402161742) do

  create_table "administrators", :force => true do |t|
    t.string   "email",                              :default => "", :null => false
    t.string   "encrypted_password",  :limit => 128, :default => "", :null => false
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "administrators", ["email"], :name => "index_administrators_on_email", :unique => true

  create_table "courses", :force => true do |t|
    t.string   "code"
    t.string   "title"
    t.string   "instructors"
    t.string   "time"
    t.string   "section"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "semester_id"
    t.integer  "cap"
    t.integer  "enrolled"
  end

  add_index "courses", ["semester_id", "code", "section"], :name => "index_courses_on_semester_id_and_code_and_section"
  add_index "courses", ["semester_id"], :name => "index_courses_on_semester_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "semesters", :force => true do |t|
    t.string   "name"
    t.datetime "starting"
    t.datetime "ending"
    t.string   "xml_url"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_enrollment_scraped_at"
    t.datetime "last_information_scraped_at"
  end

  create_table "slugs", :force => true do |t|
    t.string   "scope"
    t.string   "slug"
    t.integer  "record_id"
    t.datetime "created_at"
  end

  add_index "slugs", ["scope", "record_id", "created_at"], :name => "index_slugs_on_scope_and_record_id_and_created_at"
  add_index "slugs", ["scope", "record_id"], :name => "index_slugs_on_scope_and_record_id"
  add_index "slugs", ["scope", "slug", "created_at"], :name => "index_slugs_on_scope_and_slug_and_created_at"
  add_index "slugs", ["scope", "slug"], :name => "index_slugs_on_scope_and_slug"

  create_table "students", :force => true do |t|
    t.string   "email",         :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "random_string"
  end

  add_index "students", ["email"], :name => "index_students_on_email"

  create_table "subscriptions", :force => true do |t|
    t.integer  "course_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["course_id"], :name => "index_subscriptions_on_course_id"
  add_index "subscriptions", ["student_id"], :name => "index_subscriptions_on_student_id"

end
