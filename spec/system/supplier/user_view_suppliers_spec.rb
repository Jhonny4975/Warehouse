# frozen_string_literal: true

require 'rails_helper'

describe 'The user accesses the suppliers screen' do
  context 'when are there suppliers' do
    it 'from menu' do
      visit root_path
      within 'nav' do
        click_on 'Fornecedores'
      end

      expect(page).to have_current_path suppliers_path
    end

    it 'user see all suppliers' do
      create_list(:supplier, 2)

      visit suppliers_path

      expect(page).to have_content 'Fornecedores'
      expect(page).to have_content Supplier.first.brand_name
      expect(page).to have_content "#{Supplier.first.city} - #{Supplier.first.state}"
      expect(page).to have_content Supplier.last.brand_name
      expect(page).to have_content "#{Supplier.last.city} - #{Supplier.last.state}"
    end
  end

  context 'when there are no suppliers' do
    it 'user see a message' do
      visit suppliers_path

      expect(page).to have_content 'Não existem fornecedores cadastrados.'
    end
  end
end
