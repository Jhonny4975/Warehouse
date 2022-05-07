# frozen_string_literal: true

require 'rails_helper'

describe 'User accesses warehouse register' do
  it 'and should see registration fields' do
    visit root_path
    click_on 'register shed'

    expect(page).to have_current_path new_shed_path
    expect(page).to have_field 'Name:'
    expect(page).to have_field 'Description:'
    expect(page).to have_field 'Code:'
    expect(page).to have_field 'Address:'
    expect(page).to have_field 'City:'
    expect(page).to have_field 'Postcode:'
    expect(page).to have_field 'Area:'
  end

  context 'when to fill in the fields' do
    it 'with valid params' do
      visit root_path
      click_on 'register shed'
      fill_in 'Name:', with: Faker::Company.name
      fill_in 'Code:', with: Faker::Address.country_code_long
      fill_in 'City:', with: Faker::Address.city
      fill_in 'Area:', with: Faker::Number.decimal(l_digits: 2, r_digits: 3)
      fill_in 'Address:', with: Faker::Address.street_address
      fill_in 'Postcode:', with: Faker::Address.postcode
      fill_in 'Description:', with: Faker::Lorem.paragraph
      click_on 'Save'

      expect(page).to have_current_path shed_path(Shed.last.id)
      expect(page).to have_content 'shed successfully registered!'
    end

    it 'with empty params' do
      visit root_path
      click_on 'register shed'
      fill_in 'Name:', with: ''
      fill_in 'Description:', with: ''
      click_on 'Save'

      expect(page).to have_current_path sheds_path
      expect(page).to have_content 'invalid information, review the fields'
    end

    it 'with invalid params' do
      invalid_field = 'invalid value'

      visit root_path
      click_on 'register shed'
      fill_in 'Name:', with: Faker::Company.name
      fill_in 'Description:', with: Faker::Address.country_code_long
      fill_in 'Code:', with: invalid_field
      fill_in 'Address:', with: invalid_field
      fill_in 'City:', with: Faker::Address.street_address
      fill_in 'Postcode:', with: invalid_field
      fill_in 'Area:', with: invalid_field
      click_on 'Save'

      expect(page).to have_current_path sheds_path
      expect(page).to have_content 'invalid information, review the fields'
    end
  end
end
