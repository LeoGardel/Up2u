class DashboardController < LogadoController
  def index
	  @percTotal = 100
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
end
