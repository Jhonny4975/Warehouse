# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    Shed.all.then do |sheds|
      if sheds.empty?
        @warehouses = []

        flash[:notice] = 'there is no registered shed'
      else
        @warehouses = sheds
      end
    end
  end
end
