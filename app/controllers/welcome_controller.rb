class WelcomeController < ApplicationController
  def index
    #cookies[:curso] = "Curso de Ruby On Rails"
    #session[:curso] = "Curso de Ruby On Rails"
    @nome = params[:nome] != nil ? params[:nome] : "Fulano"
    @curso = params[:curso]
  end
end
