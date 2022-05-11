# frozen_string_literal: true

require 'rails_helper'

describe 'User accesses warehouse register' do
  it 'and should see registration fields' do
    visit root_path
    click_on 'Cadastrar galpão'

    expect(page).to have_current_path new_shed_path
    expect(page).to have_field 'Nome:'
    expect(page).to have_field 'Descrição:'
    expect(page).to have_field 'Código:'
    expect(page).to have_field 'Endereço:'
    expect(page).to have_field 'Cidade:'
    expect(page).to have_field 'Código postal:'
    expect(page).to have_field 'Área:'
  end

  context 'when to fill in the fields' do
    it 'with valid params' do
      visit root_path
      click_on 'Cadastrar galpão'
      fill_in 'Nome:', with: Faker::Company.name
      fill_in 'Código:', with: Faker::Address.country_code_long
      fill_in 'Cidade:', with: Faker::Address.city
      fill_in 'Área:', with: Faker::Number.number(digits: 5)
      fill_in 'Endereço:', with: Faker::Address.street_address
      fill_in 'Código postal:', with: %w[01234-567 08652-300 78451-123].sample
      fill_in 'Descrição:', with: Faker::Lorem.paragraph
      click_on 'Criar Galpão'

      expect(page).to have_current_path shed_path(Shed.last.id)
      expect(page).to have_content 'Galpão cadastrado com sucesso!'
    end

    it 'with empty params' do
      visit root_path
      click_on 'Cadastrar galpão'
      fill_in 'Nome:', with: ''
      fill_in 'Descrição:', with: ''
      click_on 'Criar Galpão'

      expect(page).to have_current_path sheds_path
      expect(page).to have_content 'Não foi possivel cadastrar o galpão.'
      expect(page).to have_content 'Nome não pode ficar em branco'
      expect(page).to have_content 'Código não pode ficar em branco'
      expect(page).to have_content 'Cidade não pode ficar em branco'
      expect(page).to have_content 'Área não pode ficar em branco'
      expect(page).to have_content 'Endereço não pode ficar em branco'
      expect(page).to have_content 'Código postal não pode ficar em branco'
      expect(page).to have_content 'Descrição não pode ficar em branco'
      expect(page).to have_content 'Código não possui o tamanho esperado (3 caracteres)'
    end

    it 'with invalid params' do
      invalid_field = 'invalid value'

      visit root_path
      click_on 'Cadastrar galpão'
      fill_in 'Nome:', with: Faker::Company.name
      fill_in 'Descrição:', with: Faker::Address.country_code_long
      fill_in 'Código:', with: invalid_field
      fill_in 'Endereço:', with: Faker::Address.street_address
      fill_in 'Cidade:', with: Faker::Address.street_address
      fill_in 'Código postal:', with: invalid_field
      fill_in 'Área:', with: invalid_field
      click_on 'Criar Galpão'

      expect(page).to have_current_path sheds_path
      expect(page).to have_content 'Não foi possivel cadastrar o galpão.'
      expect(page).to have_content 'Código não possui o tamanho esperado (3 caracteres)'
      expect(page).to have_content 'Código postal deve ter o formato: 00000-000'
      expect(page).to have_content 'Área não é um número'
    end
  end
end
