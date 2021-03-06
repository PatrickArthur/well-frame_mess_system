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

ActiveRecord::Schema.define(version: 20_171_101_172_359) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'conversations', force: :cascade do |t|
    t.integer  'sender_id'
    t.string   'subject'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'messages', force: :cascade do |t|
    t.text     'message_text'
    t.integer  'conversation_id'
    t.boolean  'read', default: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.integer  'sender_id'
  end

  add_index 'messages', ['conversation_id'], name: 'index_messages_on_conversation_id', using: :btree

  create_table 'participants', force: :cascade do |t|
    t.integer  'user_id'
    t.integer  'conversation_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'participants', %w(user_id conversation_id), name: 'index_participants_on_user_id_and_conversation_id', using: :btree

  create_table 'users', force: :cascade do |t|
    t.string   'username'
    t.string   'email'
    t.string   'encrypted_password'
    t.string   'salt'
    t.string   'role'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end
end
