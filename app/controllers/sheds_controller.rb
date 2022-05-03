# frozen_string_literal: true

class ShedsController < ApplicationController
  def show
    @shed = Shed.find(params[:id])
  end
end
