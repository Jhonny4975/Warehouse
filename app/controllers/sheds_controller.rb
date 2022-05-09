# frozen_string_literal: true

class ShedsController < ApplicationController
  before_action :set_shed, only: %i[show edit update destroy]

  def new
    @shed = Shed.new
  end

  def show; end

  def create
    @shed = Shed.new(shed_params)

    if @shed.save
      redirect_to shed_path(@shed.id), notice: 'Galpão cadastrado com sucesso!'
    else
      flash.now[:notice] = 'Não foi possivel cadastrar o galpão.'

      render :new
    end
  end

  def edit; end

  def update
    if @shed.update(shed_params)
      redirect_to shed_path(@shed.id), notice: 'Galpão atualizado com sucesso!'
    else
      flash.now[:notice] = 'Não foi possivel atualizar o galpão.'

      render :edit
    end
  end

  def destroy
    @shed.destroy

    flash[:notice] = 'Galpão excluído com sucesso!'
    redirect_to root_path
  end

  private

  def shed_params
    params.require(:shed).permit(
      :name,
      :code,
      :city,
      :area,
      :address,
      :postcode,
      :description
    )
  end

  def set_shed
    @shed = Shed.find(params[:id])
  end
end
