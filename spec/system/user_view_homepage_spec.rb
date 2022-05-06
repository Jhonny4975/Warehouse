# frozen_string_literal: true

require 'rails_helper'

describe 'User visits home screen' do
  context 'when there are sheds' do
    it 'must see app name' do
      create(:shed)

      visit root_path

      expect(page).to have_content 'Galpões & Estoque'
    end

    it 'the user should see the registered sheds' do
      registered_shed = create(:shed)

      visit root_path

      expect(page).not_to have_content 'there is no registered shed'
      expect(page).to have_content registered_shed.name
      expect(page).to have_content "Code: #{registered_shed.code}"
      expect(page).to have_content "City: #{registered_shed.city}"
      expect(page).to have_content "Area: #{registered_shed.area} m²"
    end
  end

  context 'when there are no sheds' do
    it 'User sees a message' do
      visit root_path

      expect(page).to have_content 'Galpões & Estoque'
      expect(page).to have_content 'there is no registered shed'
    end
  end
end
