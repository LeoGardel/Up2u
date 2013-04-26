class AddIndexToAreaComp < ActiveRecord::Migration
  def change
    add_index :area_comp, :area_id
  end
end
