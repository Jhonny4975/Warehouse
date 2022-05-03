# frozen_string_literal: true

FactoryBot.define do
  factory :shed do
    name { Faker::Company.name }
    code { Faker::Address.country_code_long }
    city { Faker::Address.city }
    area { Faker::Number.decimal(l_digits: 2, r_digits: 3) }
    address { Faker::Address.street_address }
    postcode { Faker::Address.postcode }
    description { Faker::Lorem.paragraph }
  end
end
