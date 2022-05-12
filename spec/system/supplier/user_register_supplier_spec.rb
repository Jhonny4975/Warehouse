# frozen_string_literal: true

require 'rails_helper'

describe 'The user registers a supplier' do
  context 'with valid parameters' do
    it 'from the menu' do
      visit root_path
      click_on 'Fornecedores'
      click_on 'Cadastrar Fornecedor'

      expect(page).to have_current_path new_supplier_path
      expect(page).to have_field 'Nome Fantasia:'
      expect(page).to have_field 'Razão Social:'
      expect(page).to have_field 'CNPJ:'
      expect(page).to have_field 'Endereço:'
      expect(page).to have_field 'Cidade:'
      expect(page).to have_field 'Estado:'
      expect(page).to have_field 'E-mail:'
      expect(page).to have_field 'Telefone:'
    end

    it 'and is successful' do
      attributes = build(:supplier)

      visit new_supplier_path
      fill_in 'Nome Fantasia:', with: attributes.corporate_name
      fill_in 'Razão Social:', with: attributes.brand_name
      fill_in 'CNPJ:', with: attributes.registration_number
      fill_in 'Endereço:', with: attributes.street_address
      fill_in 'Cidade:', with: attributes.city
      fill_in 'Estado:', with: attributes.state
      fill_in 'E-mail:', with: attributes.email
      fill_in 'Telefone:', with: attributes.phone_number
      click_on 'Criar Fornecedor'

      expect(page).to have_current_path supplier_path(Supplier.last.id)
      expect(page).to have_content 'Fornecedor cadastrado com sucesso!'
    end
  end

  context 'with invalid parameters' do
    it 'and fails' do
      visit new_supplier_path
      fill_in 'Nome Fantasia:', with: ''
      fill_in 'Razão Social:', with: ''
      fill_in 'CNPJ:', with: ''
      fill_in 'E-mail:', with: ''
      click_on 'Criar Fornecedor'

      expect(page).to have_current_path suppliers_path
      expect(page).to have_content 'Fornecedor não cadastrado.'
      expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
      expect(page).to have_content 'Razão Social não pode ficar em branco'
      expect(page).to have_content 'CNPJ não pode ficar em branco'
      expect(page).to have_content 'E-mail não pode ficar em branco'
      expect(page).to have_content 'CNPJ deve ter o formato: 00.000.000/0000-00'
      expect(page).to have_content 'Telefone deve ter o formato: (12) 12345-1234'
    end
  end
end
