# frozen_string_literal: true

class ShedsController < ApplicationController
  def new
    @shed = Shed.new
  end

  def show
    @shed = Shed.find(params[:id])
  end

  def create
    @shed = Shed.new(shed_params)

    if @shed.save
      redirect_to shed_path(@shed.id), notice: 'Galpão cadastrado com sucesso!'
    else
      flash.now[:notice] = 'Não foi possivel cadastrar o galpão.'

      render :new
    end
  end

  def edit
    @shed = Shed.find(params[:id])
  end

  def update
    @shed = Shed.find(params[:id])

    if @shed.update(shed_params)
      redirect_to shed_path(@shed.id), notice: 'Galpão atualizado com sucesso!'
    else
      flash.now[:notice] = 'Não foi possivel atualizar o galpão.'

      render :edit
    end
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
end
