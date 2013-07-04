class RegistrationsController < Devise::RegistrationsController
	layout "logado", :only => [:edit, :update]
end