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

ActiveRecord::Schema.define(:version => 20130426050852) do

  create_table "areas", :force => true do |t|
    t.string "nome",          :limit => 60,  :null => false
    t.string "nome_adjetivo", :limit => 60,  :null => false
    t.string "descr",         :limit => 400, :null => false
  end

  create_table "cargo_area", :force => true do |t|
    t.string  "nome",     :limit => 60,  :null => false
    t.string  "descr",    :limit => 400
    t.integer "area_id",                 :null => false
    t.integer "cargo_id",                :null => false
  end

  add_index "cargo_area", ["area_id"], :name => "area_id"

  create_table "cargo_comp", :force => true do |t|
    t.integer "cargo_id",       :null => false
    t.integer "competencia_id", :null => false
    t.text    "importancia",    :null => false
    t.integer "area_id",        :null => false
    t.float   "presenca_rel",   :null => false
  end

  create_table "cargos", :force => true do |t|
    t.string "nome",  :limit => 60,  :null => false
    t.string "descr", :limit => 400, :null => false
  end

  create_table "comp_usuarios", :force => true do |t|
    t.integer   "usuario_id",                                  :null => false
    t.integer   "competencia_id",                              :null => false
    t.integer   "nivel",                                       :null => false
    t.string    "importancia",    :limit => 12,                :null => false
    t.integer   "turno",                        :default => 0, :null => false
    t.timestamp "data",                                        :null => false
  end

  add_index "comp_usuarios", ["usuario_id"], :name => "usuario_id"

  create_table "competencias", :force => true do |t|
    t.text    "nome",                                              :null => false
    t.text    "descr"
    t.string  "caracteristica",       :limit => 60,                :null => false
    t.text    "nivel_1"
    t.text    "nivel_2"
    t.text    "nivel_3"
    t.text    "nivel_4"
    t.text    "nivel_5"
    t.integer "soma_notas_usuarios",                :default => 0, :null => false
    t.integer "quant_notas_usuarios",               :default => 0, :null => false
  end

  create_table "educacao", :force => true do |t|
    t.integer "usuario_id",                             :null => false
    t.string  "instituicao_facebook_uid", :limit => 60
    t.string  "instituicao_nome",         :limit => 60
    t.string  "ano_conclusao",            :limit => 60
    t.string  "tipo",                     :limit => 60
  end

  add_index "educacao", ["usuario_id"], :name => "index_educacao_on_usuario_id"

  create_table "myers_areas", :force => true do |t|
    t.integer "myers_tipo_id",                  :null => false
    t.integer "area_id",                        :null => false
    t.float   "porcentagem",                    :null => false
    t.float   "influencia",    :default => 1.0, :null => false
  end

  create_table "myers_perguntas", :force => true do |t|
    t.text    "pergunta",       :limit => 2147483647, :null => false
    t.integer "myers_tipo_id",                        :null => false
    t.integer "tipo_invertido",                       :null => false
  end

  create_table "myers_respostas", :force => true do |t|
    t.integer   "usuario_id",        :null => false
    t.integer   "myers_pergunta_id", :null => false
    t.integer   "resposta",          :null => false
    t.integer   "turno",             :null => false
    t.timestamp "data",              :null => false
  end

  create_table "myers_resultados", :force => true do |t|
    t.integer "usuario_id",    :null => false
    t.integer "myers_tipo_id", :null => false
    t.float   "fator",         :null => false
  end

  add_index "myers_resultados", ["usuario_id"], :name => "usuario_id"

  create_table "myers_tipos", :force => true do |t|
    t.string "descr", :limit => 60, :null => false
  end

  create_table "trabalho", :force => true do |t|
    t.integer "usuario_id",                            :null => false
    t.string  "empregador_facebook_uid", :limit => 60
    t.string  "empregador_nome",         :limit => 60
    t.string  "data_inicio",             :limit => 60
    t.string  "data_fim",                :limit => 60
    t.string  "cargo",                   :limit => 60
    t.string  "local",                   :limit => 60
  end

  add_index "trabalho", ["usuario_id"], :name => "index_trabalho_on_usuario_id"

  create_table "usuario_form", :force => true do |t|
    t.text    "nome",      :null => false
    t.text    "email",     :null => false
    t.text    "senha",     :null => false
    t.text    "data_nasc", :null => false
    t.integer "area"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nome",                        :limit => 60
    t.string   "sobrenome",                   :limit => 60
    t.text     "descr",                       :limit => 16777215
    t.string   "email",                       :limit => 60,                       :null => false
    t.date     "data_nasc"
    t.integer  "cargo_id"
    t.text     "imagem"
    t.integer  "area_id"
    t.text     "porque"
    t.integer  "pergunta_atual_competencias"
    t.integer  "turno_competencias",                              :default => 0,  :null => false
    t.integer  "pergunta_atual_perfil"
    t.integer  "turno_perfil",                                    :default => 0,  :null => false
    t.string   "encrypted_password",                              :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                   :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "facebook_uid"
  end

  add_index "usuarios", ["confirmation_token"], :name => "index_usuarios_on_confirmation_token", :unique => true
  add_index "usuarios", ["email"], :name => "index_usuarios_on_email", :unique => true
  add_index "usuarios", ["facebook_uid"], :name => "index_usuarios_on_facebook_uid", :unique => true
  add_index "usuarios", ["reset_password_token"], :name => "index_usuarios_on_reset_password_token", :unique => true

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
