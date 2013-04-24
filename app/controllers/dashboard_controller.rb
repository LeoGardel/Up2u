class DashboardController < ApplicationController
  before_filter :authenticate_usuario!
  def index
	
  end
  
  def editar_cargo_area
	@areas = Area.all
	@cargos = Cargo.all
  end

  def salvar_cargo_area
  	current_usuario.update_cargo_area(params["area"]["area_id"], params["cargo"]["cargo_id"])
  	redirect_to :action => "index"
  end
end
