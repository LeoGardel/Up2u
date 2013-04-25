class AreaComp < ActiveRecord::Base
  self.table_name = "area_comp"
  belongs_to :area
  belongs_to :competencia

  def self.lista_competencias_por_area(area_id)
    list = AreaComp.where(:area_id => area_id).pluck(:competencia_id).uniq
    list.reverse!
  end
end
