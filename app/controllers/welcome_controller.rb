class WelcomeController < ApplicationController
  def index
    @nome = params[:nome] != nil ? params[:nome] : "Fulano"
    @curso = params[:curso]
  end
end
