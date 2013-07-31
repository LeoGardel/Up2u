class CargoArea < ActiveRecord::Base
  self.table_name = "cargo_area"
  belongs_to :area
  belongs_to :cargo

  public
    def self.getNomeEDescr(area, cargo)
      CargoArea.where("area_id = ? AND cargo_id = ?", area, cargo).map { |e| {:nome => e.nome, :descr => e.descr} }[0]
    end
end
