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

ActiveRecord::Schema.define(:version => 0) do

  create_table "atodate", :force => true do |t|
    t.date     "atoDate",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configvalues", :force => true do |t|
    t.string   "name",       :limit => 20,  :null => false
    t.string   "value",      :limit => 200
    t.integer  "ivalue"
    t.date     "dvalue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cybercontrols", :force => true do |t|
    t.integer  "originalID",                                           :null => false
    t.string   "Revision",           :limit => 10,  :default => "3"
    t.integer  "controlNumber",                                        :null => false
    t.integer  "parentControlKey"
    t.string   "controlFamilyCode",  :limit => 2
    t.string   "controlName",        :limit => 256
    t.string   "controlType",        :limit => 20
    t.integer  "enhancement"
    t.text     "controlDescription"
    t.string   "impactLevel",        :limit => 3
    t.boolean  "criticalControl",                   :default => false
    t.text     "guidance"
    t.boolean  "quarterly",                         :default => false
    t.string   "priority",           :limit => 12
    t.boolean  "withdrawn",                         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cyberstage", :force => true do |t|
    t.integer "controlNumber"
    t.string  "controlType",        :limit => 20
    t.string  "controlFamilyCode",  :limit => 2
    t.string  "controlFamilyName",  :limit => 40
    t.integer "withdrawn",          :limit => 1
    t.string  "controlName",        :limit => 256
    t.string  "priority",           :limit => 12
    t.text    "controlDescription"
    t.text    "guidance"
    t.integer "originalID"
    t.string  "revision",           :limit => 10
    t.integer "criticalControl",    :limit => 1
    t.string  "impact",             :limit => 12
    t.integer "quarterly",          :limit => 1
    t.string  "controlNumberText",  :limit => 12
  end

  create_table "enclavecontrols", :force => true do |t|
    t.integer  "enclave_id",                                                              :null => false
    t.integer  "enclaveYear",                                                             :null => false
    t.integer  "cybercontrol_id",                                                         :null => false
    t.boolean  "RMF",                                                  :default => false, :null => false
    t.string   "SSPImplementationStatus",               :limit => 30
    t.text     "SSPImplementationDescription"
    t.string   "implementingDocumentationOrArticfacts"
    t.string   "deviationIdentifier"
    t.string   "testMethod",                            :limit => 20
    t.string   "testProcedure"
    t.date     "plannedTestDate"
    t.string   "scheduledTestYear",                     :limit => 6
    t.date     "actualTestDate"
    t.string   "testResult",                            :limit => 20
    t.text     "testResultDescription"
    t.string   "assessorName",                          :limit => 100
    t.string   "cAndADoc"
    t.string   "controlReference"
    t.integer  "enclaveQuarter"
    t.integer  "enclavequarter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enclavequarters", :force => true do |t|
    t.integer  "enclave_id"
    t.integer  "enclaveQuarter"
    t.integer  "enclaveYear"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enclaves", :force => true do |t|
    t.string   "Name",       :limit => 24
    t.string   "long_name"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                   :default => true
  end

  create_table "enclavestage", :force => true do |t|
    t.integer "enclave_id",                                           :null => false
    t.integer "enclaveYear",                                          :null => false
    t.integer "control_id"
    t.integer "RMF",                                   :limit => 1,   :null => false
    t.string  "SSPImplementationStatus",               :limit => 30
    t.text    "SSPImplementationDescription"
    t.string  "implementingDocumentationOrArticfacts"
    t.string  "deviationIdentifier"
    t.string  "testMethod",                            :limit => 20
    t.string  "testProcedure"
    t.date    "plannedTestDate"
    t.string  "scheduledTestYear",                     :limit => 6
    t.date    "actualTestDate"
    t.string  "testResult",                            :limit => 20
    t.text    "testResultDescription"
    t.string  "assessorName",                          :limit => 100
    t.string  "cAndADoc"
    t.string  "controlReference"
    t.integer "enclaveQuarter",                                       :null => false
    t.string  "controlFamilyCode",                     :limit => 2,   :null => false
    t.integer "controlNumber",                                        :null => false
    t.integer "enhancement"
  end

  create_table "enhancestage", :force => true do |t|
    t.string  "controlNumberText",  :limit => 12
    t.integer "controlNumber"
    t.string  "controlFamilyName",  :limit => 40
    t.string  "controlFamilyCode",  :limit => 2
    t.integer "enhancement"
    t.string  "impact",             :limit => 12
    t.text    "controlDescription"
    t.text    "guidance"
    t.integer "originalID"
    t.string  "Revision",           :limit => 10, :default => "3"
    t.integer "parentControlKey"
    t.integer "criticalControl",    :limit => 1
    t.integer "quarterly",          :limit => 1
    t.string  "priority",           :limit => 12
    t.integer "withdrawn",          :limit => 1
  end

  create_table "implementationstatuses", :force => true do |t|
    t.string   "ImplementationStatus", :limit => 30, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "testmethods", :force => true do |t|
    t.string   "TestMethod", :limit => 20, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "testresults", :force => true do |t|
    t.string   "TestResult", :limit => 20, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
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
    t.string   "group"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
