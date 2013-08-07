class Area < ActiveRecord::Base

  def self.recalcula_pontuacao_maxima_diretores
  	Area.all.each { |a|
  	  pontuacao = 0
  	  lista = CargoComp.lista_importancias_por_cargo_area(a.id, 6).each { |b|
  	    if b[:importancia] == "ESSENCIAL"
  	  	  pontuacao += 3 * 5
  	  	elsif b[:importancia] == "CLASSIFICATORIA"
  	  	  pontuacao += 1 * 5
  	  	end
  	  }
  	  a[:pontuacao_max_diretor] = pontuacao
  	  a.save
  	}
  end

end
