class DashboardController < LogadoController
  def index
	
  end
  
  def editar_cargo_area
	@areas = Area.all
	@cargos = Cargo.all
  end

  def salvar_cargo_area
  	current_usuario.update_cargo_area(params["area"]["area_id"].to_i, params["cargo"]["cargo_id"].to_i)
    usuario_session.delete("lista_competencias")
  	redirect_to :action => "index"
  end
end
