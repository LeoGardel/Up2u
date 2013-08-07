# coding: utf-8

class DashboardController < LogadoController
  def index
    @tetoBasico = 41
    @tetoAvancado = 71

	  @percTotal = current_usuario.resultado_competencias

    @usuariosBasicos = 489
    @usuariosAvancados = 215
    @usuariosExperientes = 85

    @competenciasBasico = []
    @competenciasAvancado = []
    @competenciasExperiente = []

    CompUsuario.respostas_turno(current_usuario.id, current_usuario.turno_competencias).each{ |resp|
      comp_nome = Competencia.find(resp[:competencia_id])[:nome]
      link = "http://www.emagister.com.br/web/search/?action=search&origen=buscador_principal&esBusquedaUsuario=1&q="
      link += comp_nome.gsub(' ','+')
      importancia = resp[:importancia]
      pontuacao = resp[:nivel] * 20
      pontuacao_outros = 50

      lista_final = [comp_nome, link, importancia, pontuacao, pontuacao_outros]

      if pontuacao < @tetoBasico
        @competenciasBasico.push lista_final
      elsif pontuacao < @tetoAvancado
        @competenciasAvancado.push lista_final
      else
        @competenciasExperiente.push lista_final
      end
    }

    if current_usuario.cargo && current_usuario.area
      @cargo_area = CargoArea.getNomeEDescr(current_usuario.cargo.id, current_usuario.area.id)[:nome]
      @cargo_area_font = get_tamanho_fonte_aba_esquerda(@cargo_area.length)
    end

    if @percTotal
      if @percTotal < @tetoBasico
        @nivel = 1
      elsif @percTotal < @tetoAvancado
        @nivel = 2
      else
        @nivel = 3
      end
    end
    
  end
  
  def editar_cargo_area
	  @areas = Area.all
	  @cargos = Cargo.all
    @descrAreas = Area.all.map { |e| e[:descr] }
    @descrCargos = Cargo.all.map { |e| e[:descr] }

    if current_usuario.area
      @area_atual = current_usuario.area.id
    else
      @area_atual = -1
    end

    if current_usuario.cargo
      @cargo_atual = current_usuario.cargo.id
    else
      @cargo_atual = -1
    end

    if current_usuario.area and current_usuario.cargo
      @cargoArea = CargoArea.getNomeEDescr(current_usuario.area, current_usuario.cargo)
    end
  end

  def salvar_cargo_area
  	current_usuario.update_cargo_area(params["area"]["area_id"].to_i, params["cargo"]["cargo_id"].to_i)
    usuario_session.delete("lista_competencias")
  	redirect_to :action => "index"
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
