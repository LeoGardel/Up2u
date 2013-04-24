class CargoAreaComp < ActiveRecord::Base
  self.table_name = "cargo_comp"
  belongs_to :area
  belongs_to :cargo
  belongs_to :competencia
end
