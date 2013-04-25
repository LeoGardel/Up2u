class AreaComp < ActiveRecord::Base
  self.table_name = "area_comp"
  belongs_to :area
  belongs_to :competencia

  def put_in_user_session_by_area(area_id)
    AreaComp::where(:area_id => area_id).select("competencia_id").uniq
    #colocar na session do usuario
  end
end
