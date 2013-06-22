class RegistrationsController < Devise::RegistrationsController
	layout "logado", :only => :edit
end