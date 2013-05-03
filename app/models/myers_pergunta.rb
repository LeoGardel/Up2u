class MyersPergunta < ActiveRecord::Base
  self.table_name = "myers_perguntas"
  belongs_to :myers_tipo

  def self.get_perguntas_id
    list = MyersPergunta.pluck(:id)
    list.reverse!
  end
end
