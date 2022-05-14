# frozen_string_literal: true

require 'rails_helper'

describe 'User edit a supplier' do
  it 'from the details page' do
    registered_supplier = create(:supplier)

    visit supplier_path(registered_supplier.id)
    click_on 'Editar'

    expect(page).to have_current_path edit_supplier_path(registered_supplier.id)
    expect(page).to have_content "Editar #{registered_supplier.brand_name}"
    expect(page).to have_field 'Nome Fantasia:', with: registered_supplier.corporate_name
    expect(page).to have_field 'CNPJ:', with: registered_supplier.registration_number
    expect(page).to have_field 'Endereço:', with: registered_supplier.street_address
    expect(page).to have_field 'Cidade:', with: registered_supplier.city
    expect(page).to have_field 'Estado:', with: registered_supplier.state
    expect(page).to have_field 'E-mail:', with: registered_supplier.email
    expect(page).to have_field 'Telefone:', with: registered_supplier.phone_number
    expect(page).to have_content 'Home'
  end

  context 'when to fill in the fields' do
    it 'with valid params' do
      attributes = build(:supplier)
      registered_supplier = create(:supplier)

      visit supplier_path(registered_supplier.id)
      click_on 'Editar'
      fill_in 'Nome Fantasia:', with: attributes.corporate_name
      fill_in 'Razão Social:', with: attributes.brand_name
      fill_in 'CNPJ:', with: attributes.registration_number
      fill_in 'Endereço:', with: attributes.street_address
      fill_in 'Cidade:', with: attributes.city
      fill_in 'Estado:', with: attributes.state
      fill_in 'E-mail:', with: attributes.email
      fill_in 'Telefone:', with: attributes.phone_number
      click_on 'Atualizar Fornecedor'

      expect(page).to have_current_path supplier_path(registered_supplier.id)
      expect(page).to have_content 'Fornecedor atualizado com sucesso!'
    end

    it 'with empty params' do
      registered_supplier = create(:supplier)

      visit supplier_path(registered_supplier.id)
      click_on 'Editar'
      fill_in 'Nome Fantasia:', with: ''
      fill_in 'Razão Social:', with: ''
      fill_in 'CNPJ:', with: ''
      fill_in 'Endereço:', with: ''
      fill_in 'Cidade:', with: ''
      fill_in 'Estado:', with: ''
      fill_in 'E-mail:', with: ''
      fill_in 'Telefone:', with: ''
      click_on 'Atualizar Fornecedor'

      expect(page).to have_current_path supplier_path(registered_supplier.id)
      expect(page).to have_content 'Não foi possível atualizar o fornecedor.'
      expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
      expect(page).to have_content 'Razão Social não pode ficar em branco'
      expect(page).to have_content 'CNPJ não pode ficar em branco'
      expect(page).to have_content 'E-mail não pode ficar em branco'
      expect(page).to have_content 'CNPJ deve ter o formato: 00.000.000/0000-00'
      expect(page).to have_content 'Telefone deve ter o formato: (12) 12345-1234'
    end
  end
end
