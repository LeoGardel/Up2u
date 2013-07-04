# -*- encoding : utf-8 -*-

class MyMailer < Devise::Mailer
	default :from => "\"Up2U Support\" <carreiraup2u@gmail.com>"
	
	def password_generation(user, password, provider)
	  @nome = user.nome
	  @sobrenome = user.sobrenome
	  @provider = provider
	  @password = password
	  mail(:to => user.email, :subject => "Bem vindo, aqui está sua senha!")
  	end
end