class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :facebook_uid, :password, :password_confirmation, :remember_me, :nome, :sobrenome, :imagem
  # attr_accessible :title, :body


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
        usuario.save
        usuario.send_email_with_password(password_token, "Facebook")
      else
        usuario.facebook_uid = auth.uid
        usuario.save
      end
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

end