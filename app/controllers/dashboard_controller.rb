# coding: utf-8

class DashboardController < LogadoController
  def index
	  @percTotal = 50

    @usuariosBasicos = 489
    @usuariosAvancados = 215
    @usuariosExperientes = 85

    @competenciasBasico = [["Habilidade com excel", "http://www.google.com", 31, 75], ["Conhecimento em Microsoft Access", "http://www.facebook.com", 14, 97], ["Habilidade com word", 100, 0]]
    @competenciasAvancado = [["Sagacidade", "http://www.google.com", 23, 12], ["Análise de Custo Computacional", 10, 79], ["Raciocínio Lógico", "http://www.facebook.com", 44, 36], ["Frieza", "http://www.facebook.com", 80, 26]]
    @competenciasExperiente = [["Html, CSS e Javascript", "http://www.google.com", 7, 88], ["Ruby, Java ou Banco de Dados", "http://www.facebook.com", 20, 66]]

    if current_usuario.cargo && current_usuario.area
      @cargo_area = CargoArea.getNomeEDescr(current_usuario.cargo.id, current_usuario.area.id)[:nome]
      @cargo_area_font = get_tamanho_fonte_aba_esquerda(@cargo_area.length)
    end

    @tetoBasico = 41
    @tetoAvancado = 71

    if @percTotal < @tetoBasico
      @nivel = 1
    elsif @percTotal < @tetoAvancado
      @nivel = 2
    else
      @nivel = 3
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
