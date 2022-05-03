# frozen_string_literal: true

require 'rails_helper'

describe 'User visits home screen' do
  subject(:home) { visit root_path }

  context 'when there are sheds' do
    let(:shed) { create(:shed) }

    before do
      shed
      home
    end

    it 'must see app name' do
      expect(page).to have_content('Galpões & Estoque')
    end

    it 'the user should see the registered sheds' do
      expect(page).not_to have_content('there is no registered shed')
      expect(page).to have_content(shed.name)
      expect(page).to have_content("code: #{shed.code}")
      expect(page).to have_content("city: #{shed.city}")
      expect(page).to have_content("#{shed.area} m2")
    end
  end

  context 'when there are no sheds' do
    before { home }

    it 'must see app name' do
      expect(page).to have_content('Galpões & Estoque')
    end

    it 'User sees a message' do
      expect(page).to have_content('there is no registered shed')
    end
  end
end
