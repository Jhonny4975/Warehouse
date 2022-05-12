# frozen_string_literal: true

require 'rails_helper'

describe 'User accesses the details of a supplier' do
  it 'Must see additional information' do
    registered_supplier = create(:supplier)

    visit suppliers_path
    click_on registered_supplier.brand_name

    expect(page).to have_content "Fornecedor #{registered_supplier.brand_name}"
    expect(page).to have_content registered_supplier.corporate_name
    expect(page).to have_content "CNPJ: #{registered_supplier.registration_number}"
    expect(page).to have_content "Endereço: #{registered_supplier.street_address}"\
                                 " - #{registered_supplier.city}"\
                                 " - #{registered_supplier.state}"

    expect(page).to have_content "E-mail: #{registered_supplier.email}"
    expect(page).to have_link 'Home'
  end

  it 'the user returns to the home screen' do
    registered_supplier = create(:supplier)

    visit suppliers_path
    click_on registered_supplier.brand_name
    click_on 'Home'

    expect(page).to have_current_path root_path
  end
end
