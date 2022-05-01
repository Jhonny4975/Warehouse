# frozen_string_literal: true

require 'rails_helper'

describe 'User visits home screen' do
  it 'must see app name' do
    visit('/')

    expect(page).to have_content('Galpões & Estoque')
  end
end
