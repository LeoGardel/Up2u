class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :facebook_uid, :password, :password_confirmation, :remember_me, :nome, :sobrenome, :imagem
  # attr_accessible :title, :body

  has_many :trabalhos
  has_many :educacoes

  belongs_to :area
  belongs_to :cargo
  belongs_to :competencia, :foreign_key => :pergunta_atual_competencias


  def self.find_for_facebook_oauth(auth)
    usuario = Usuario.where(:facebook_uid => auth.uid).first
    unless usuario
      usuario = Usuario.where(:email => auth.info.email).first
      unless usuario
        password_token = Devise.friendly_token[0,10]
        usuario = Usuario.new(facebook_uid:auth.uid,
                             email:auth.info.email,
                             password:password_token,
                             nome:auth.info.first_name,
                             sobrenome:auth.info.last_name,
                             imagem:auth.info.image
                             )
        usuario.skip_confirmation!
        usuario.send_email_with_password(password_token, "Facebook")
      else
        usuario.facebook_uid = auth.uid
      end
      usuario.save_work_history_facebook(auth.extra.raw_info.work)
      usuario.save_education_history_facebook(auth.extra.raw_info.education)
      unless usuario.imagem
        usuario.imagem = auth.info.image
      end
      usuario.save
    end
    unless usuario.confirmed?
      usuario.skip_confirmation!
      usuario.save
    end
    usuario
  end

  def send_email_with_password(password_token, provider_name)
    MyMailer.password_generation(self, password_token, provider_name).deliver
  end

  def save_work_history_facebook(work_list)
    if work_list
      work_list.each do |work|
        if work.employer.present?
          empregador_facebook_uid = work.employer.id
          empregador_nome = work.employer.name
        end
        if work.position.present?
          cargo = work.position.name
        end
        if work.location.present?
          local = work.location.name
        end

        self.trabalhos.build :empregador_facebook_uid => empregador_facebook_uid,
          :empregador_nome => empregador_nome,
          :data_inicio => work.start_date,
          :data_fim => work.end_date,
          :cargo => cargo,
          :local => local
      end
    end
  end

  def save_education_history_facebook(education_list)
    if education_list
      education_list.each do |education|
        if education.school.present?
          instituicao_facebook_uid = education.school.id
          instituicao_nome = education.school.name
        else
          instituicao_facebook_uid = nil
          instituicao_nome = nil
        end
        if education.year.present?
          ano_conclusao = education.year.name
        else
          ano_conclusao = nil
        end

        self.educacoes.build :instituicao_facebook_uid => instituicao_facebook_uid,
          :instituicao_nome => instituicao_nome,
          :ano_conclusao => ano_conclusao,
          :tipo => education.type
      end
    end
  end

  def update_cargo_area(area_id, cargo_id)
    if (self.area_id != area_id) or (self.cargo_id != cargo_id)
      self.area_id = area_id
      self.cargo_id = cargo_id
      self.resetar_resultado_competencias
      self.pergunta_atual_competencias = nil
      self.save
    end
  end

  def resetar_resultado_competencias
    if self.pergunta_atual_competencias.nil? and !(resultado_competencias.nil?)
      if self.resultado_competencias < TETO_BASICO
        nivel_usu = NivelUsuario.find(1)
      elsif self.resultado_competencias < TETO_AVANCADO
        nivel_usu = NivelUsuario.find(2)
      else
        nivel_usu = NivelUsuario.find(3)
      end
      nivel_usu[:quant_usuarios] -= 1
      nivel_usu.save
    end
    self.resultado_competencias = nil
    self.save
  end

  def definir_resultado_competencias(pontuacao)
    if pontuacao < TETO_BASICO
      nivel_usu = NivelUsuario.find(1)
    elsif pontuacao < TETO_AVANCADO
      nivel_usu = NivelUsuario.find(2)
    else
      nivel_usu = NivelUsuario.find(3)
    end
    nivel_usu[:quant_usuarios] += 1
    nivel_usu.save
    
    self.resultado_competencias = pontuacao
    self.save
  end
end