# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if Shed.all.empty?
      @sheds = []

      flash[:notice] = 'Não há nenhum galpão cadastrado...'
    else
      @sheds = Shed.all
    end
  end
end
