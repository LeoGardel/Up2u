# -*- encoding : utf-8 -*-

class QuestionarioCompetenciasController < ApplicationController
  before_filter :authenticate_usuario!, :possui_cargo_area?
  def instrucoes
		
  end

  def prox_pergunta
    atualiza_session_com_competencias
    competencia = Competencia.find(current_usuario.pergunta_atual_competencias)
    @pergunta = competencia[:nome]
    @nivel1 = competencia[:nivel_1]
    @nivel2 = competencia[:nivel_2]
    @nivel3 = competencia[:nivel_3]
    @nivel4 = competencia[:nivel_4]
    @nivel5 = competencia[:nivel_5]
    binding.pry
  end

  def registrar_resposta
    atualiza_session_com_competencias
    CompUsuario.registrar_resposta params["nivel"]
    unless usuario_session["lista_competencias_pendentes"].empty?
      current_usuario.pergunta_atual_competencias = usuario_session["lista_competencias_pendentes"].pop
      current_usuario.save
      redirect_to :action => "prox_pergunta"
    else
      current_usuario.pergunta_atual_competencias = nil
      current_usuario.save
      redirect_to :action => "exibe_resultados"
    end
  end

  def exibe_resultados

  end

protected

  def possui_cargo_area?
    unless current_usuario.area_id && current_usuario.cargo_id
      flash[:alert] = "Você tem que escolher um cargo e uma área antes de responder o questionário."
      redirect_to dashboard_editar_cargo_area_path
    end
  end
end