class MyersResposta < ActiveRecord::Base
  self.table_name = "myers_respostas"
  belongs_to :usuario
  belongs_to :myers_pergunta

  attr_accessible :resposta, :turno

  def self.registrar_resposta(id, pergunta_atual_perfil, resposta, turno)
    resposta = MyersResposta.new(resposta:resposta, turno:turno)
    resposta.usuario_id = id
    resposta.myers_pergunta_id = pergunta_atual_perfil
    resposta.save
  end

  def self.agrupar_respostas_usuario(usuario_id, turno)
    respostas = MyersResposta.select("myers_tipo_id AS tipo, 
      (SUM( (resposta)*(CAST(tipo_invertido AS UNSIGNED)*2) )* -1 + 2 * COUNT(*))/ (4 * COUNT(*))
      AS fator").where(usuario_id:usuario_id).where(turno:turno).joins(:myers_pergunta).group(:myers_tipo_id)
  end
end
