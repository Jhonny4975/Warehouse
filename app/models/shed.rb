# frozen_string_literal: true

class Shed < ApplicationRecord
  validates :name,
            :code,
            :city,
            :area,
            :address,
            :postcode,
            :description, presence: true
  validates :code, length: { is: 3 }
end
