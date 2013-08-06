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
    @respostas = MyersResposta.select("myers_pergunta_id, resposta").where(usuario_id:usuario_id).where(turno:turno)
    @tipos = Hash.new
    MyersTipo.all.each { |tipo|
      @tipos[tipo[:id]] = [0,0]
    }
    @respostas.each { |resp|
      @pergunta = MyersPergunta.find(resp[:myers_pergunta_id])
      if @pergunta[:tipo_invertido] == 1
        @tipos[@pergunta.myers_tipo_id][0] += resp[:resposta] * -1
      else
        @tipos[@pergunta.myers_tipo_id][0] += resp[:resposta]
      end
      @tipos[@pergunta.myers_tipo_id][1] += 1
    }
    MyersResultado.salva_hash_resultados(usuario_id, @tipos)
  end
end
