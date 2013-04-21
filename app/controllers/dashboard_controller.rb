class DashboardController < ApplicationController
	def index
		
	end

	def editar_cargo_area
		@areas = Area.all
		@cargos = Cargo.all
	end

	def salvar_cargo_area
		current_usuario.area_id = params["area"]["area_id"]
		current_usuario.cargo_id = params["cargo"]["cargo_id"]
		current_usuario.save
		redirect_to :action => "index"
	end
end
