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
  validates :code, :name, uniqueness: true

  validates :area, numericality: { greater_than: 20 }

  validates :postcode, format: { with: /\A\d{5}-\d{3}\z/,
                                 message: 'deve ter o formato: 00000-000' }
end
