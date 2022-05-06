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
      expect(page).to have_content 'Galpões & Estoque'
    end

    it 'the user should see the registered sheds' do
      expect(page).not_to have_content 'there is no registered shed'
      expect(page).to have_content registered_shed.name
      expect(page).to have_content "Code: #{registered_shed.code}"
      expect(page).to have_content "City: #{registered_shed.city}"
      expect(page).to have_content "Area: #{registered_shed.area} m²"
    end
  end

  context 'when there are no sheds' do
    before { home }

    it 'User sees a message' do
      expect(page).to have_content 'Galpões & Estoque'
      expect(page).to have_content 'there is no registered shed'
    end
  end
end
