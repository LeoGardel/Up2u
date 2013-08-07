class CompUsuario < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :competencia

  attr_accessible :nivel, :turno, :importancia

  def self.registrar_resposta(id, pergunta_atual_competencias, nivel, importancia, turno)
    comp = CompUsuario.new(nivel:nivel, turno:turno, importancia: importancia)
    comp.usuario_id = id
    comp.competencia_id = pergunta_atual_competencias
    comp.save
  end

  def self.respostas_turno(usuario_id, turno)
    CompUsuario.where(usuario_id: usuario_id).where(turno: turno).map { |e|
     {competencia_id: e[:competencia_id], importancia: e[:importancia], nivel: e[:nivel]}
 	}
  end

  def self.calcula_pontuacao(usuario_id, turno, area_id)
  	pontuacao_perdida = 0
  	CompUsuario.where(usuario_id: usuario_id).where(turno: turno).each { |e|
	  if e[:importancia] == "ESSENCIAL"
		pontuacao_perdida += 3 * ( 5 - e[:nivel] )
	  elsif e[:importancia] == "CLASSIFICATORIA"
		pontuacao_perdida += 1 * ( 5 - e[:nivel] )
	  end
  	}
  	pontuacao_max_diretor = Area.find(area_id)[:pontuacao_max_diretor]
  	(pontuacao_max_diretor - pontuacao_perdida) * 100 / pontuacao_max_diretor
  end
end
