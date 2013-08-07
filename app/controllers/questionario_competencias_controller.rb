# -*- encoding : utf-8 -*-

class QuestionarioCompetenciasController < LogadoController
  before_filter :authenticate_usuario!, :possui_cargo_area?
  helper_method :atualiza_session_com_competencias, :inicializa_pergunta_atual

  def instrucoes
		
  end

  def prox_pergunta
    atualiza_session_com_competencias
    inicializa_pergunta_atual unless current_usuario.pergunta_atual_competencias
    competencia = Competencia.find(current_usuario.pergunta_atual_competencias)
    @pergunta = competencia[:nome]
    @nivel_1 = competencia[:nivel_1]
    @nivel_2 = competencia[:nivel_2]
    @nivel_3 = competencia[:nivel_3]
    @nivel_4 = competencia[:nivel_4]
    @nivel_5 = competencia[:nivel_5]
    @total = usuario_session["lista_competencias"].length
    @respondidos = @total - usuario_session["lista_competencias"].index( usuario_session["lista_competencias"].detect{ |el| el[:competencia_id] == current_usuario.pergunta_atual_competencias } ) - 1

    @porcentagem = @respondidos * 100 / @total

    @barras_cheias = @porcentagem * 7 / 100
    @altura_barra_parcial =  (@porcentagem * 7) % 100
    @barras_vazias = 7 - @barras_cheias
    if @altura_barra_parcial != 0
      @barras_vazias = @barras_vazias - 1
    end
  end

  def registrar_resposta
    usuario_session["lista_competencias"] = CargoComp.lista_competencias_por_cargo_area(current_usuario.area_id, current_usuario.cargo_id)
    if current_usuario.pergunta_atual_competencias
      if params[:nivel] && [1,2,3,4,5].include?(params[:nivel].to_i)
        atualiza_session_com_competencias
        posicao_atual = usuario_session["lista_competencias"].index( usuario_session["lista_competencias"].detect{ |el| el[:competencia_id] == current_usuario.pergunta_atual_competencias } )
        CompUsuario.registrar_resposta current_usuario.id, current_usuario.pergunta_atual_competencias, params[:nivel].to_i, usuario_session["lista_competencias"][posicao_atual][:importancia], current_usuario.turno_competencias
        unless posicao_atual == 0
          current_usuario.pergunta_atual_competencias = usuario_session["lista_competencias"][posicao_atual - 1][:competencia_id]
          current_usuario.save
          redirect_to :action => "prox_pergunta"
        else
          current_usuario.pergunta_atual_competencias = nil
          current_usuario.resultado_competencias = CompUsuario.calcula_pontuacao(current_usuario.id, current_usuario.turno_competencias, current_usuario.area_id)
          current_usuario.save
          usuario_session.delete("lista_competencias")
          redirect_to dashboard_index_path
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

  def atualiza_session_com_competencias
    unless usuario_session["lista_competencias"]
      usuario_session["lista_competencias"] = CargoComp.lista_competencias_por_cargo_area(current_usuario.area_id, current_usuario.cargo_id)
    end
  end

  def inicializa_pergunta_atual
    current_usuario.pergunta_atual_competencias = usuario_session["lista_competencias"].last[:competencia_id]
    current_usuario.turno_competencias += 1
    current_usuario.resultado_competencias = nil
    current_usuario.save
  end

protected

  def possui_cargo_area?
    unless current_usuario.area_id && current_usuario.cargo_id
      flash[:alert] = "Você tem que escolher um cargo e uma área antes de responder o questionário."
      redirect_to dashboard_editar_cargo_area_path
    end
  end
end