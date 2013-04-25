class CompUsuario < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :competencia

  def self.registrar_resposta(nivel)
    CompUsuario.new(usuario_id:current_usuario.id,
                    competencia_id:current_usuario.pergunta_atual_competencias,
                    nivel:nivel)
  end
end
