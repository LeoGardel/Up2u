class CargoComp < ActiveRecord::Base
  self.table_name = "cargo_comp"
  belongs_to :area
  belongs_to :competencia
  belongs_to :cargo

  def self.lista_competencias_por_cargo_area(area_id, cargo_id)
    list = CargoComp.select("competencia_id, importancia").where(area_id: area_id).where(cargo_id: cargo_id)
    list.reverse!
  end

  def self.lista_importancias_por_cargo_area(area_id, cargo_id)
    list = CargoComp.select(:importancia).where(area_id: area_id).where(cargo_id: cargo_id)
  end
end
