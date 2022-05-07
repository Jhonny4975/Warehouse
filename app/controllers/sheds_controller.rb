# frozen_string_literal: true

class ShedsController < ApplicationController
  def new
    @shed = Shed.new
  end

  def show
    @shed = Shed.find(params[:id])
  end

  def create
    Shed.new(shed_params).then do |shed|
      if shed.save
        redirect_to shed_path(shed.id), notice: 'shed successfully registered!'
      else
        flash.now[:notice] = 'invalid information, review the fields!'

        render :new
      end
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
