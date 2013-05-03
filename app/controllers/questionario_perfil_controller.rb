# -*- encoding : utf-8 -*-

class QuestionarioPerfilController < ApplicationController
  before_filter :authenticate_usuario!
  helper_method :atualiza_session_com_perguntas_id, :inicializa_pergunta_atual

  def instrucoes
		
  end

  def prox_pergunta
    atualiza_session_com_perguntas_id
    inicializa_pergunta_atual
    pergunta = MyersPergunta.find(current_usuario.pergunta_atual_perfil)
    @pergunta = pergunta[:pergunta]
    @nivel_2 = "Muito Adequado"
    @nivel_1 = "Adequado"
    @nivel_0 = "Regular "
    @nivel_m1 = "Inadequado"
    @nivel_m2 = "Muito Inadequado"
    @total = usuario_session["lista_perfil"].length
    @respondidos = @total - usuario_session["lista_perfil"].index(current_usuario.pergunta_atual_perfil) - 1
  end

  def registrar_resposta
    if current_usuario.pergunta_atual_perfil
      if [2,1,0,-1,-2].include?(params[:resposta].to_i)
        atualiza_session_com_perguntas_id
        MyersResposta.registrar_resposta current_usuario.id, current_usuario.pergunta_atual_perfil, params[:resposta].to_i, current_usuario.turno_perfil
        posicao_atual = usuario_session["lista_perfil"].index(current_usuario.pergunta_atual_perfil)
        unless posicao_atual == 0
          current_usuario.pergunta_atual_perfil = usuario_session["lista_perfil"][posicao_atual - 1]
          current_usuario.save
          redirect_to :action => "prox_pergunta"
        else
          current_usuario.pergunta_atual_perfil = nil
          current_usuario.save
          usuario_session.delete("lista_perfil")
          redirect_to :action => "resultados"
        end
      else
        flash[:alert] = "Você tem que escolher uma das alternativas do questionário."
        redirect_to :action => "prox_pergunta"
      end
    else
      flash[:alert] = "Você não está em um questionário."
      redirect_to dashboard_index_path
    end
  end

  def resultados
    unless current_usuario.pergunta_atual_perfil
      @fatores = MyersResposta.agrupar_respostas_usuario(current_usuario.id, current_usuario.turno_perfil)
    else
      flash[:alert] = "Você precisa terminar o questionário para colher os resultados."
      redirect_to :action => "prox_pergunta"
    end
  end

  def inicializa_pergunta_atual
    unless current_usuario.pergunta_atual_perfil
      current_usuario.pergunta_atual_perfil = usuario_session["lista_perfil"].last
      current_usuario.turno_perfil += 1
      current_usuario.save
    end
  end

  def atualiza_session_com_perguntas_id
    unless usuario_session["lista_perfil"]
      usuario_session["lista_perfil"] = MyersPergunta.get_perguntas_id
    end
  end
end