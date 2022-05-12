# frozen_string_literal: true

FactoryBot.define do
  factory :supplier do
    corporate_name { Faker::Company.name }
    brand_name { Faker::Company.industry }
    registration_number { Faker::Company.brazilian_company_number(formatted: true) }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    email { Faker::Internet.email }
    phone_number { generate_phone_number }
  end
end

def generate_phone_number
  "(#{Faker::Number.number(digits: 2)}) #{Faker::Number.number(digits: 5)}-#{Faker::Number.number(digits: 4)}"
end
