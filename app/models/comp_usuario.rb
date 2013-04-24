class CompUsuario < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :competencia
end
