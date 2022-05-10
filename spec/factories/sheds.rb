# frozen_string_literal: true

FactoryBot.define do
  factory :shed do
    name { Faker::Company.name }
    code { Faker::Address.country_code_long }
    city { Faker::Address.city }
    area { Faker::Number.number(digits: 5) }
    address { Faker::Address.street_address }
    postcode { %w[01234-567 08652-300 78451-123].sample }
    description { Faker::Lorem.paragraph }
  end
end
