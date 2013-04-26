class CompUsuario < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :competencia

  attr_accessible :nivel, :turno

  def self.registrar_resposta(id, pergunta_atual_competencias, nivel, turno)
    comp = CompUsuario.new(nivel:nivel, turno:turno)
    comp.usuario_id = id
    comp.competencia_id = pergunta_atual_competencias
    comp.save
  end
end
