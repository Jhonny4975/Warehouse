# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Shed, type: :model do
  describe 'are there validations?' do
    context 'with presence' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:code) }
      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_presence_of(:area) }
      it { is_expected.to validate_presence_of(:address) }
      it { is_expected.to validate_presence_of(:postcode) }
      it { is_expected.to validate_presence_of(:description) }
    end

    context 'with length' do
      it { is_expected.to validate_length_of(:code).is_equal_to(3) }
    end

    context 'with uniqueness' do
      it { is_expected.to validate_uniqueness_of(:code) }
    end
  end

  describe '#valid?' do
    context 'with presence' do
      it 'valid when all fields are present' do
        shed = described_class.new(attributes_for(:shed))

        expect(shed).to be_valid
      end

      it 'invalid when name is not present' do
        shed = described_class.new(attributes_for(:shed, name: ''))

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Nome não pode ficar em branco'
      end

      it 'invalid when code is not present' do
        shed = described_class.new(attributes_for(:shed, code: ''))

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 2
        expect(shed.errors.full_messages.first).to eq 'Código não pode ficar em branco'
        expect(shed.errors.full_messages.last).to eq 'Código não possui o tamanho esperado (3 caracteres)'
      end

      it 'invalid when city is not present' do
        shed = described_class.new(attributes_for(:shed, city: ''))

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Cidade não pode ficar em branco'
      end

      it 'invalid when area is not present' do
        shed = described_class.new(attributes_for(:shed, area: ''))

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Área não pode ficar em branco'
      end

      it 'invalid when address is not present' do
        shed = described_class.new(attributes_for(:shed, address: ''))

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Endereço não pode ficar em branco'
      end

      it 'invalid when postcode is not present' do
        shed = described_class.new(attributes_for(:shed, postcode: ''))

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Código postal não pode ficar em branco'
      end

      it 'invalid when description is not present' do
        shed = described_class.new(attributes_for(:shed, description: ''))

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Descrição não pode ficar em branco'
      end
    end

    context 'with uniqueness' do
      it 'invalid when code is already in use' do
        create(:shed, code: 'ASU')
        second_shed = described_class.new(attributes_for(:shed, code: 'ASU'))

        expect(second_shed).not_to be_valid
        expect(second_shed.errors.full_messages.length).to eq 1
        expect(second_shed.errors.full_messages.last).to eq 'Código já está em uso'
      end
    end
  end
end
