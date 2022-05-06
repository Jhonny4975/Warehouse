# frozen_string_literal: true

require 'rails_helper'

describe 'User accesses the details of a shed' do
  it 'Must see additional information' do
    registered_shed = create(:shed)

    visit root_path
    click_on registered_shed.name

    expect(page).to have_content "Shed #{registered_shed.code}"
    expect(page).to have_content "Name: #{registered_shed.name}"
    expect(page).to have_content "City: #{registered_shed.city}"
    expect(page).to have_content "Area: #{registered_shed.area} m2"
    expect(page).to have_content "Address: #{registered_shed.address}"
    expect(page).to have_content "Postcode: #{registered_shed.postcode}"
    expect(page).to have_content "Description: #{registered_shed.description}"
    expect(page).to have_link 'Home'
  end

  it 'the user returns to the home screen' do
    registered_shed = create(:shed)

    visit root_path
    click_on registered_shed.name
    click_on 'Home'

    expect(page).to have_current_path root_path
  end
end
