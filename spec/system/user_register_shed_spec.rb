# frozen_string_literal: true

require 'rails_helper'

describe 'User accesses warehouse register' do
  subject(:register) { click_on 'register shed' }

  let(:home) { visit root_path }
  let(:post) do
    fill_in 'Name:', with: Faker::Company.name
    fill_in 'Description:', with: Faker::Address.country_code_long
    fill_in 'Code:', with: Faker::Address.city
    fill_in 'Address:', with: Faker::Number.decimal(l_digits: 2, r_digits: 3)
    fill_in 'City:', with: Faker::Address.street_address
    fill_in 'Postcode:', with: Faker::Address.postcode
    fill_in 'Area:', with: Faker::Lorem.paragraph
    click_on 'Save'
  end

  before do
    home
    register
  end

  it 'and should see registration fields' do
    expect(page).to have_current_path new_shed_path
    expect(page).to have_field 'Name:'
    expect(page).to have_field 'Description:'
    expect(page).to have_field 'Code:'
    expect(page).to have_field 'Address:'
    expect(page).to have_field 'City:'
    expect(page).to have_field 'Postcode:'
    expect(page).to have_field 'Area:'
  end

  it 'and register a shed' do
    post

    expect(page).to have_current_path shed_path(Shed.last.id)
    expect(page).to have_content 'shed successfully registered!'
  end
end
