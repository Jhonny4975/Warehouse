# frozen_string_literal: true

require 'rails_helper'

describe 'User edit a shed' do
  it 'from the details page' do
    registered_shed = create(:shed)

    visit shed_path(registered_shed.id)
    click_on 'Editar'

    expect(page).to have_current_path edit_shed_path(registered_shed.id)
    expect(page).to have_content "Editar #{registered_shed.name}"
    expect(page).to have_field('Nome:', with: registered_shed.name)
    expect(page).to have_field('Descrição:', with: registered_shed.description)
    expect(page).to have_field('Código:', with: registered_shed.code)
    expect(page).to have_field('Endereço:', with: registered_shed.address)
    expect(page).to have_field('Cidade:', with: registered_shed.city)
    expect(page).to have_field('Código postal:', with: registered_shed.postcode)
    expect(page).to have_field('Área:', with: registered_shed.area)
    expect(page).to have_content 'Home'
  end

  context 'when to fill in the fields' do
    it 'with valid params' do
      registered_shed = create(:shed)

      visit shed_path(registered_shed.id)
      click_on 'Editar'
      fill_in 'Nome:', with: 'my name'
      fill_in 'Código:', with: 'UFC'
      fill_in 'Cidade:', with: 'my city'
      fill_in 'Área:', with: '10000'
      fill_in 'Endereço:', with: 'my address'
      fill_in 'Código postal:', with: 'my postal code'
      fill_in 'Descrição:', with: 'my description'
      click_on 'Atualizar Galpão'

      expect(page).to have_current_path shed_path(registered_shed.id)
      expect(page).to have_content 'Galpão atualizado com sucesso!'
      expect(page).to have_content 'Galpão UFC'
      expect(page).to have_content 'Nome: my name'
      expect(page).to have_content 'Cidade: my city'
      expect(page).to have_content 'Área: 10000 m2'
      expect(page).to have_content 'Endereço: my address'
      expect(page).to have_content 'Código postal: my postal code'
      expect(page).to have_content 'Descrição: my description'
    end

    it 'with empty params' do
      registered_shed = create(:shed)

      visit shed_path(registered_shed.id)
      click_on 'Editar'
      fill_in 'Nome:', with: ''
      fill_in 'Descrição:', with: ''
      fill_in 'Código:', with: ''
      fill_in 'Endereço:', with: ''
      fill_in 'Cidade:', with: ''
      fill_in 'Código postal:', with: ''
      fill_in 'Área:', with: ''
      click_on 'Atualizar Galpão'

      expect(page).to have_current_path shed_path(registered_shed.id)
      expect(page).to have_content 'Não foi possivel atualizar o galpão.'
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
      registered_shed = create(:shed)
      invalid_field = 'invalid value'

      visit shed_path(registered_shed.id)
      click_on 'Editar'
      fill_in 'Nome:', with: Faker::Company.name
      fill_in 'Descrição:', with: Faker::Address.country_code_long
      fill_in 'Código:', with: invalid_field
      fill_in 'Endereço:', with: invalid_field
      fill_in 'Cidade:', with: Faker::Address.street_address
      fill_in 'Código postal:', with: invalid_field
      fill_in 'Área:', with: invalid_field
      click_on 'Atualizar Galpão'

      expect(page).to have_current_path shed_path(registered_shed.id)
      expect(page).to have_content 'Não foi possivel atualizar o galpão.'
      expect(page).to have_content 'Código não possui o tamanho esperado (3 caracteres)'
    end
  end
end
