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
        self.trabalhos.build :empregador_facebook_uid => work.employer.id,
          :empregador_nome => work.employer.name,
          :data_inicio => work.start_date,
          :data_fim => work.end_date,
          :cargo => work.position.name,
          :local => work.location.name
      end
    end
  end

  def save_education_history_facebook(education_list)
    if education_list
      education_list.each do |education|
        self.educacoes.build :instituicao_facebook_uid => education.school.id,
          :instituicao_nome => education.school.name,
          :ano_conclusao => education.year.name,
          :tipo => education.type
      end
    end
  end

  def update_cargo_area(area_id, cargo_id)
    if (self.area_id != area_id) or (self.cargo_id != cargo_id)
      self.area_id = area_id
      self.cargo_id = cargo_id
      self.pergunta_atual_competencias = nil
      self.save
    end
  end
end