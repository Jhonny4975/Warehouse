# frozen_string_literal: true

class SuppliersController < ApplicationController
  def index
    if Supplier.all.empty?
      @suppliers = []

      flash[:notice] = 'Não existem fornecedores cadastrados.'
    else
      @suppliers = Supplier.all
    end
  end
end
