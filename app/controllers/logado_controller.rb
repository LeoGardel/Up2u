class LogadoController < ApplicationController
  before_filter :authenticate_usuario!
end
