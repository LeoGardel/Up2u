class Educacao < ActiveRecord::Base
  self.table_name = "educacao"
  attr_accessible :instituicao_facebook_uid, :instituicao_nome, :ano_conclusao, :tipo
  belongs_to :usuario
end
