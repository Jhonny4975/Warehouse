# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    Shed.all.then do |sheds|
      if sheds.empty?
        @sheds = []

        flash[:notice] = 'Não há nenhum galpão cadastrado...'
      else
        @sheds = sheds
      end
    end
  end
end
