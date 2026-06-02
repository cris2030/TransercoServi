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

ActiveRecord::Schema[7.2].define(version: 2026_06_01_182725) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "asignacion_metas", force: :cascade do |t|
    t.bigint "unidad_id", null: false
    t.bigint "meta_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meta_id"], name: "index_asignacion_metas_on_meta_id"
    t.index ["unidad_id"], name: "index_asignacion_metas_on_unidad_id"
  end

  create_table "meta", force: :cascade do |t|
    t.string "name"
    t.integer "km_start"
    t.integer "km_end"
    t.string "color"
    t.integer "importance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metas", force: :cascade do |t|
    t.string "nombre"
    t.integer "kilometraje_inicio"
    t.integer "kilometraje_final"
    t.string "color"
    t.integer "nivel_imp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "metas_unidads", force: :cascade do |t|
    t.integer "unit_id"
    t.bigint "meta_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meta_id"], name: "index_metas_unidads_on_meta_id"
  end

  create_table "services", force: :cascade do |t|
    t.integer "unit_id"
    t.string "unit_name"
    t.string "plates"
    t.date "last_service_date"
    t.integer "last_service_odometer"
    t.integer "current_service_odometer"
    t.integer "target_odometer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "servicios", force: :cascade do |t|
    t.bigint "unidad_id", null: false
    t.integer "kilometraje"
    t.date "fecha"
    t.string "nom_mecanico"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unidad_id"], name: "index_servicios_on_unidad_id"
  end

  create_table "unidades", force: :cascade do |t|
    t.string "unitID"
    t.string "codigo"
    t.string "placa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unitID"], name: "index_unidades_on_unitID"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "asignacion_metas", "metas"
  add_foreign_key "asignacion_metas", "unidades"
  add_foreign_key "metas_unidads", "meta"
  add_foreign_key "servicios", "unidades"
end
