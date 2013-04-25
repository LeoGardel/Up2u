# -*- encoding : utf-8 -*-

class QuestionarioCompetenciasController < ApplicationController
  before_filter :authenticate_usuario!, :possui_cargo_area?
  def instrucoes
		
  end

  def prox_pergunta
    if usuario_session.empty?
      #colocar lista de perguntar a serem feitas na session
      list = AreaComp::put_in_user_session_by_area current_usuario.area_id
      binding.pry
    end
  end

  def registrar_resposta
    CompUsuario.new(usuario_id:current_usuario.id,
                    competencia_id:current_usuario.pergunta_atual_competencias,
                    nivel:params["nivel"])
    redirect_to :action => "prox_pergunta"
  end

protected

  def possui_cargo_area?
    unless current_usuario.area_id && current_usuario.cargo_id
      flash[:alert] = "Você tem que escolher um cargo e uma área antes de responder o questionário."
      redirect_to dashboard_editar_cargo_area_path
    end
  end
end