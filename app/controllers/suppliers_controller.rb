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

  def show
    @supplier = Supplier.find(params[:id])
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save
      redirect_to @supplier, notice: 'Fornecedor cadastrado com sucesso!'
    else
      flash.now[:notice] = 'Fornecedor não cadastrado.'

      render :new
    end
  end

  private

  def supplier_params
    params.require(:supplier).permit(
      :corporate_name,
      :brand_name,
      :registration_number,
      :street_address,
      :city,
      :state,
      :email,
      :phone_number
    )
  end
end
