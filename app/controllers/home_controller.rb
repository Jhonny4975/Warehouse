# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @warehouses = Shed.all
  end
end
