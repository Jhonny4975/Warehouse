# frozen_string_literal: true

require 'rails_helper'

describe 'User visits home screen' do
  let(:shed) { create(:shed) }

  before do
    shed
    visit('/')
  end

  it 'must see app name' do
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'the user should see the registered sheds' do
    expect(page).to have_content(shed.name)
    expect(page).to have_content("code: #{shed.code}")
    expect(page).to have_content("city: #{shed.city}")
    expect(page).to have_content("#{shed.city} m2")
  end
end
