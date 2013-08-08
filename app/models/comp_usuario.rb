class CompUsuario < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :competencia

  attr_accessible :nivel, :turno, :importancia

  def self.registrar_resposta(id, pergunta_atual_competencias, nivel, importancia, turno)
    ultima_resposta = CompUsuario.where(usuario_id: id).where(competencia_id: pergunta_atual_competencias).order("data DESC").limit(1)

    comp_usuario = CompUsuario.new(nivel:nivel, turno:turno, importancia: importancia)
    comp_usuario.usuario_id = id
    comp_usuario.competencia_id = pergunta_atual_competencias

    comp = Competencia.find(pergunta_atual_competencias)
    comp[:soma_notas_usuarios] += nivel * 20
    if ultima_resposta && ultima_resposta.length == 1
      comp[:soma_notas_usuarios] -= ultima_resposta[0][:nivel] * 20
    else
      comp[:quant_notas_usuarios] += 1
    end

    ## os 2 devem ser dentro de uma transacao
    comp_usuario.save
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
