# frozen_string_literal: true

class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[show edit update]

  def index
    if Supplier.all.empty?
      @suppliers = []

      flash[:notice] = 'Não existem fornecedores cadastrados.'
    else
      @suppliers = Supplier.all
    end
  end

  def show; end

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

  def edit; end

  def update
    if @supplier.update(supplier_params)
      redirect_to @supplier, notice: 'Fornecedor atualizado com sucesso!'
    else
      flash.now[:notice] = 'Não foi possível atualizar o fornecedor.'

      render :edit
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

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end
end
