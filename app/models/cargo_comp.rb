class CargoComp < ActiveRecord::Base
  self.table_name = "cargo_comp"
  belongs_to :area
  belongs_to :competencia
  belongs_to :cargo

  def self.lista_competencias_por_area(area_id)
    list = CargoComp.where(:area_id => area_id).pluck(:competencia_id).uniq
    list.reverse!
  end
end
