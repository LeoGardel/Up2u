class MyersResultado < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :myers_tipo

  attr_accessible :fator, :myers_tipo_id, :usuario_id

  def self.salva_hash_resultados(usuario_id, hash)
    hash.each_key { |key| 
      @resultado = MyersResultado.where(usuario_id: usuario_id).where(myers_tipo_id: key)[0]
      if @resultado
        @resultado[:fator] = ( hash[key][0] + ( 2 * hash[key][1] ) ) * 100 / ( 4 * hash[key][1] ).to_f
        @resultado.save
      else
        @resultado = MyersResultado.new(myers_tipo_id: key,
                           usuario_id: usuario_id,
                           fator: ( hash[key][0] + ( 2 * hash[key][1] ) ) * 100 / ( 4 * hash[key][1] ).to_f )
        @resultado.save
      end
    }
  end
end
