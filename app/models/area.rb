class Area < ActiveRecord::Base
  self.table_name = "area"
  attr_reader :area, :descr
end
