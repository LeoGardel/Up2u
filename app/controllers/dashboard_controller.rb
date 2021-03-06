# coding: utf-8

class DashboardController < LogadoController
  def index
	  @percTotal = current_usuario.resultado_competencias

    usuariosBasicos = NivelUsuario.find(1)[:quant_usuarios]
    usuariosAvancados = NivelUsuario.find(2)[:quant_usuarios]
    usuariosExperientes = NivelUsuario.find(3)[:quant_usuarios]

    @usuarios = [ usuariosBasicos, usuariosAvancados, usuariosExperientes ]

    competenciasBasico = []
    competenciasAvancado = []
    competenciasExperiente = []

    if current_usuario.cargo && current_usuario.area
      @cargo_area = CargoArea.getNomeEDescr(current_usuario.area.id, current_usuario.cargo.id)[:nome]
      @cargo_area_font = get_tamanho_fonte_aba_esquerda(@cargo_area.length)
    end

    if @percTotal
      if @percTotal < TETO_BASICO
        @nivel = 1
      elsif @percTotal < TETO_AVANCADO
        @nivel = 2
      else
        @nivel = 3
      end

      CompUsuario.respostas_turno(current_usuario.id, current_usuario.turno_competencias).each{ |resp|
        comp = Competencia.find(resp[:competencia_id])
        comp_nome = comp[:nome]
        link = "http://www.emagister.com.br/web/search/?action=search&origen=buscador_principal&esBusquedaUsuario=1&q="
        link += comp_nome.gsub(' ','+')
        importancia = resp[:importancia]
        pontuacao = resp[:nivel] * 20
        if comp[:quant_notas_usuarios] != 0 ## Provisorio
          pontuacao_outros = comp[:soma_notas_usuarios] / comp[:quant_notas_usuarios]
        else
          pontuacao_outros = 50
        end

        lista_final = [comp_nome, link, importancia, pontuacao, pontuacao_outros]

        if pontuacao < TETO_BASICO
          competenciasBasico.push lista_final
        elsif pontuacao < TETO_AVANCADO
          competenciasAvancado.push lista_final
        else
          competenciasExperiente.push lista_final
        end
      }
    end

    @competencias = [ competenciasBasico, competenciasAvancado, competenciasExperiente ]
    
  end
  
  def editar_cargo_area
	  @areas = Area.all
	  @cargos = Cargo.all

    if current_usuario.area.present?
      @area_atual = current_usuario.area.id
    else
      @area_atual = -1
    end

    if current_usuario.cargo.present?
      @cargo_atual = current_usuario.cargo.id
    else
      @cargo_atual = -1
    end

    if current_usuario.area.present? and current_usuario.cargo.present?
      @cargoArea = CargoArea.getNomeEDescr(current_usuario.area.id, current_usuario.cargo.id)
    end
  end

  def salvar_cargo_area
    current_usuario.update_cargo_area(params["area"]["area_id"].to_i, params["cargo"]["cargo_id"].to_i)
    usuario_session.delete("lista_competencias")
    redirect_to :action => "index"
  end

  def atualizar_cargo_area
    area = Area.where(nome: params["areaNome"]).limit(1)[0]
    cargo = Cargo.where(nome: params["cargoNome"]).limit(1)[0]

    unless area.nil? or cargo.nil?
      cargoArea = CargoArea.getNomeEDescr(area[:id], cargo[:id])
    else
      if area.nil?
        area = {}
      end
      if cargo.nil?
        cargo = {}
      end
      cargoArea = {}
    end

    resposta = {"areaDescr" => area[:descr],
     "cargoDescr" => cargo[:descr],
      "cargoAreaNome" => cargoArea[:nome],
       "cargoAreaDescr" => cargoArea[:descr]}

    respond_to do |format|
      format.json { render :json => resposta.to_json }
    end
  end

  def get_tamanho_fonte_aba_esquerda(len)
    if len > 23
      return 11
    elsif len > 19
      return 12
    else
      return 14
    end
  end

end
