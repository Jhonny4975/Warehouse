# frozen_string_literal: true

class ShedsController < ApplicationController
  def new
    @shed = Shed.new
  end

  def show
    @shed = Shed.find(params[:id])
  end

  def create
    Shed.create!(shed_params).then do |shed|
      flash[:notice] = 'shed successfully registered!'

      redirect_to shed_path(shed.id)
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
