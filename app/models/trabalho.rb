class Trabalho < ActiveRecord::Base
  self.table_name = "trabalho"
  attr_accessible :empregador_facebook_uid, :empregador_nome, :data_inicio, :data_fim, :cargo, :local
  belongs_to :usuario
end
