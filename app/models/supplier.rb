# frozen_string_literal: true

class Supplier < ApplicationRecord
  validates :corporate_name,
            :brand_name,
            :registration_number,
            :email, presence: true

  validates :brand_name,
            :registration_number,
            :email, uniqueness: true

  validates :registration_number, format: { with: %r{\A\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}\z},
                                            message: 'deve ter o formato: 00.000.000/0000-00' }

  validates :phone_number, format: { with: /\A\(\d{2}\) \d{5}-\d{4}\z/,
                                     message: 'deve ter o formato: (12) 12345-1234' }
end
