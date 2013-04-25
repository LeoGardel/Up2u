module CompetenciasHelper
  def atualiza_session_com_competencias
    unless usuario_session["lista_competencias_pendentes"]
      lista = AreaComp.lista_competencias_por_area(current_usuario.area_id)
      if current_usuario.pergunta_atual_competencias
        lista = lista[0..lista.index(current_usuario.pergunta_atual_competencias)]
      else
        current_usuario.pergunta_atual_competencias = lista.pop
      end
      current_usuario.save
      usuario_session["lista_competencias_pendentes"] = lista
    end
  end
end
