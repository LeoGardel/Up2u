class PainelUsuarioController < ApplicationController
	def index
		@areas = Area.all
		@cargos = Cargo.all
	end

	def redefinir_cargo_area
		#current_usuario.area = 
	end
end
