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

ActiveRecord::Schema.define(:version => 20130326213848) do

  create_table "area", :force => true do |t|
    t.string "area",  :limit => 60, :null => false
    t.string "descr", :limit => 60, :null => false
  end

  create_table "area_comp", :force => true do |t|
    t.integer "id_area",                      :null => false
    t.integer "id_comp",                      :null => false
    t.string  "Caracteristica", :limit => 60, :null => false
  end

  create_table "caract_comp", :force => true do |t|
    t.text "importancia", :null => false
  end

  create_table "cargo_almejado", :force => true do |t|
    t.string  "nome_cargo",  :limit => 60, :null => false
    t.string  "descr_cargo", :limit => 60
    t.integer "id_area",                   :null => false
    t.integer "id_cargo",                  :null => false
  end

  create_table "cargo_comp", :force => true do |t|
    t.integer "id_cargo",     :null => false
    t.integer "id_comp",      :null => false
    t.text    "importancia",  :null => false
    t.integer "id_area",      :null => false
    t.float   "presenca_rel", :null => false
  end

  create_table "cargo_geral", :force => true do |t|
    t.string "cargo", :limit => 60, :null => false
    t.string "descr", :limit => 60, :null => false
  end

  create_table "carreira", :force => true do |t|
    t.string  "carreira", :limit => 60, :null => false
    t.string  "descr",    :limit => 60, :null => false
    t.integer "cargo_1",                :null => false
    t.integer "cargo_2"
    t.integer "cargo_3"
    t.integer "cargo_4"
    t.integer "cargo_5"
    t.integer "cargo_6"
  end

  create_table "comp_usuarios_conh", :force => true do |t|
    t.integer "id_usuario", :null => false
    t.integer "id_comp",    :null => false
    t.integer "id_exp",     :null => false
  end

  create_table "comp_usuarios_exp", :force => true do |t|
    t.integer "id_usuario", :null => false
    t.integer "id_comp",    :null => false
    t.integer "id_exp",     :null => false
  end

  create_table "comp_usuarios_gosto", :force => true do |t|
    t.integer "id_usuario", :null => false
    t.integer "id_comp",    :null => false
    t.integer "id_exp",     :null => false
  end

  create_table "competencias", :force => true do |t|
    t.text "comp",           :limit => 2147483647, :null => false
    t.text "descr",          :limit => 2147483647
    t.text "caracteristica", :limit => 2147483647, :null => false
    t.text "nivel_1",        :limit => 2147483647
    t.text "nivel_2",        :limit => 2147483647
    t.text "nivel_3",        :limit => 2147483647
    t.text "nivel_4",        :limit => 2147483647
    t.text "nivel_5",        :limit => 2147483647
  end

  create_table "educacao", :force => true do |t|
    t.integer "id_usuario"
    t.string  "id_facebook",     :limit => 60
    t.string  "nome",            :limit => 60
    t.string  "ano_id_facebook", :limit => 60
    t.string  "ano",             :limit => 60
    t.string  "tipo",            :limit => 60
  end

  create_table "facebook", :force => true do |t|
    t.string "facebook_id",  :limit => 20
    t.string "name",         :limit => 200
    t.string "email",        :limit => 200
    t.string "gender",       :limit => 10
    t.date   "birthday"
    t.string "location",     :limit => 200
    t.string "hometown",     :limit => 200
    t.text   "bio"
    t.string "relationship", :limit => 30
    t.string "timezone",     :limit => 10
    t.text   "access_token"
  end

  create_table "hist_comp", :force => true do |t|
    t.integer "id_usuario"
    t.string  "data",          :limit => 60
    t.integer "nivel_comp_1"
    t.integer "nivel_comp_2"
    t.integer "nivel_comp_3"
    t.integer "nivel_comp_4"
    t.integer "nivel_comp_5"
    t.integer "nivel_comp_6"
    t.integer "nivel_comp_7"
    t.integer "nivel_comp_8"
    t.integer "nivel_comp_9"
    t.integer "nivel_comp_10"
    t.integer "nivel_comp_11"
    t.integer "nivel_comp_12"
    t.integer "nivel_comp_13"
    t.integer "nivel_comp_14"
    t.integer "nivel_comp_15"
    t.integer "nivel_comp_16"
    t.integer "nivel_comp_17"
    t.integer "nivel_comp_18"
    t.integer "nivel_comp_19"
    t.integer "nivel_comp_20"
    t.integer "nivel_comp_21"
    t.integer "nivel_comp_22"
    t.integer "nivel_comp_23"
    t.integer "nivel_comp_24"
    t.integer "nivel_comp_25"
    t.integer "nivel_comp_26"
    t.integer "nivel_comp_27"
    t.integer "nivel_comp_28"
    t.integer "nivel_comp_29"
    t.integer "nivel_comp_30"
    t.integer "nivel_comp_31"
    t.integer "nivel_comp_32"
    t.integer "nivel_comp_33"
    t.integer "nivel_comp_34"
    t.integer "nivel_comp_35"
    t.integer "nivel_comp_36"
    t.integer "comp_1"
    t.integer "comp_2"
    t.integer "comp_3"
    t.integer "comp_4"
    t.integer "comp_5"
    t.integer "comp_6"
    t.integer "comp_7"
    t.integer "comp_8"
    t.integer "comp_9"
    t.integer "comp_10"
    t.integer "comp_11"
    t.integer "comp_12"
    t.integer "comp_13"
    t.integer "comp_14"
    t.integer "comp_15"
    t.integer "comp_16"
    t.integer "comp_17"
    t.integer "comp_18"
    t.integer "comp_19"
    t.integer "comp_20"
    t.integer "comp_21"
    t.integer "comp_22"
    t.integer "comp_23"
    t.integer "comp_24"
    t.integer "comp_25"
    t.integer "comp_26"
    t.integer "comp_27"
    t.integer "comp_28"
    t.integer "comp_29"
    t.integer "comp_30"
    t.integer "comp_31"
    t.integer "comp_32"
    t.integer "comp_33"
    t.integer "comp_34"
    t.integer "comp_35"
    t.integer "comp_36"
  end

  create_table "myers_areas", :force => true do |t|
    t.integer "myers",       :null => false
    t.integer "area",        :null => false
    t.float   "porcentagem", :null => false
  end

  create_table "myers_perguntas", :force => true do |t|
    t.text   "pergunta", :limit => 2147483647, :null => false
    t.string "tipo",     :limit => 60,         :null => false
  end

  create_table "myers_respostas", :force => true do |t|
    t.integer "id_usuario",  :null => false
    t.integer "id_pergunta", :null => false
    t.integer "resposta",    :null => false
  end

  create_table "myers_tipos", :force => true do |t|
    t.string "descr", :limit => 60, :null => false
  end

  create_table "trabalho", :force => true do |t|
    t.integer "id_usuario"
    t.string  "id_facebook", :limit => 60
    t.string  "nome",        :limit => 60
    t.string  "inicio",      :limit => 60
    t.string  "fim",         :limit => 60
  end

  create_table "usuario", :force => true do |t|
    t.string  "nome",         :limit => 60,         :null => false
    t.text    "descr",        :limit => 2147483647, :null => false
    t.string  "login",        :limit => 60,         :null => false
    t.string  "senha",        :limit => 60,         :null => false
    t.string  "email",        :limit => 60,         :null => false
    t.string  "data_nasc",    :limit => 60,         :null => false
    t.integer "id_cargo_alm",                       :null => false
    t.integer "id_carreira",                        :null => false
    t.text    "facebook_id",  :limit => 2147483647
    t.text    "imagem"
    t.integer "id_area",                            :null => false
    t.text    "porque",       :limit => 2147483647
  end

  create_table "usuario_form", :force => true do |t|
    t.text    "nome",      :null => false
    t.text    "email",     :null => false
    t.text    "senha",     :null => false
    t.text    "data_nasc", :null => false
    t.integer "area"
  end

  create_table "vagas", :force => true do |t|
    t.integer "id_area",                             :null => false
    t.text    "cargo",                               :null => false
    t.float   "salario",                             :null => false
    t.integer "num_vagas",                           :null => false
    t.text    "hierarquia",    :limit => 2147483647, :null => false
    t.text    "cidade",                              :null => false
    t.text    "estado",                              :null => false
    t.text    "nome_empresa",                        :null => false
    t.text    "area_empresa",  :limit => 2147483647, :null => false
    t.text    "porte",                               :null => false
    t.text    "nacionalidade",                       :null => false
    t.text    "area_atuacao",  :limit => 2147483647, :null => false
    t.integer "id_cargo",                            :null => false
  end

end
