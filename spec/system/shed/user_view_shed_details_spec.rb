# frozen_string_literal: true

require 'rails_helper'

describe 'User accesses the details of a shed' do
  it 'Must see additional information' do
    registered_shed = create(:shed)

    visit root_path
    click_on registered_shed.name

    expect(page).to have_content "Galpão #{registered_shed.code}"
    expect(page).to have_content "Nome: #{registered_shed.name}"
    expect(page).to have_content "Cidade: #{registered_shed.city}"
    expect(page).to have_content "Área: #{registered_shed.area} m2"
    expect(page).to have_content "Endereço: #{registered_shed.address}"
    expect(page).to have_content "Código postal: #{registered_shed.postcode}"
    expect(page).to have_content "Descrição: #{registered_shed.description}"
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
