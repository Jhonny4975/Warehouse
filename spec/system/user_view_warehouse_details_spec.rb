# frozen_string_literal: true

require 'rails_helper'

describe 'User accesses the details of a shed' do
  subject(:details) { click_on shed.name }

  let(:home) { visit root_path }
  let(:shed) { create(:shed) }

  before do
    shed
    home
    details
  end

  it 'Must see additional information' do
    expect(page).to have_content("Shed #{shed.code}")
    expect(page).to have_content("Name: #{shed.name}")
    expect(page).to have_content("City: #{shed.city}")
    expect(page).to have_content("Area: #{shed.area} m2")
    expect(page).to have_content("Address: #{shed.address}")
    expect(page).to have_content("Postcode: #{shed.postcode}")
    expect(page).to have_content("Description: #{shed.description}")
    expect(page).to have_link('Home')
  end

  it 'the user returns to the home screen' do
    click_on 'Home'

    expect(page).to have_current_path(root_path)
  end
end
