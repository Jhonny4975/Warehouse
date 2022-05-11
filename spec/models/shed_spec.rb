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
      it { is_expected.to validate_numericality_of(:area).is_greater_than(20) }
    end

    context 'with uniqueness' do
      it { is_expected.to validate_uniqueness_of(:name) }
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
        expect(shed.errors.full_messages.length).to eq 2
        expect(shed.errors.full_messages.first).to eq 'Área não pode ficar em branco'
        expect(shed.errors.full_messages.last).to eq 'Área não é um número'
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
        expect(shed.errors.full_messages.length).to eq 2
        expect(shed.errors.full_messages.first).to eq 'Código postal não pode ficar em branco'
        expect(shed.errors.full_messages.last).to eq 'Código postal deve ter o formato: 00000-000'
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

      it 'invalid when name is already in use' do
        first_shed = create(:shed, name: 'SP')
        second_shed = described_class.new(attributes_for(:shed, name: 'SP'))


        expect(second_shed).not_to be_valid
        expect(second_shed.errors.full_messages.length).to eq 1
        expect(second_shed.errors.full_messages.last).to eq 'Nome já está em uso'
      end
    end

    context 'with length' do
      it 'invalid when the area is not greater than 20' do
        shed = described_class.new(attributes_for(:shed, area: 1))

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Área deve ser maior que 20'
      end

      it 'invalid when code length is not 3' do
        error_message = 'Código não possui o tamanho esperado (3 caracteres)'
        first_shed = described_class.new(attributes_for(:shed, code: 'ASUD'))
        second_shed = described_class.new(attributes_for(:shed, code: 'AS'))

        expect(first_shed).not_to be_valid
        expect(second_shed).not_to be_valid
        expect(first_shed.errors.full_messages.length).to eq 1
        expect(second_shed.errors.full_messages.length).to eq 1
        expect(first_shed.errors.full_messages.last).to eq error_message
        expect(second_shed.errors.full_messages.last).to eq error_message
      end
    end

    context 'with format validation' do
      it 'valid when postcode matches format' do
        shed = described_class.new(attributes_for(:shed, postcode: %w[01234-567 08652-300 78451-123].sample))

        expect(shed).to be_valid
        expect(shed.errors).to be_empty
      end

      it 'invalid when postcode does not match format' do
        shed = described_class.new(attributes_for(:shed, postcode: '451165415469'))

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Código postal deve ter o formato: 00000-000'
      end
    end

    context 'when editing a shed' do
      it 'invalid when name is not present' do
        shed = create(:shed)

        shed.update(name: '')

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Nome não pode ficar em branco'
      end

      it 'invalid when code is not present' do
        shed = create(:shed)

        shed.update(code: '')

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 2
        expect(shed.errors.full_messages.first).to eq 'Código não pode ficar em branco'
        expect(shed.errors.full_messages.last).to eq 'Código não possui o tamanho esperado (3 caracteres)'
      end

      it 'invalid when city is not present' do
        shed = create(:shed)

        shed.update(city: '')

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Cidade não pode ficar em branco'
      end

      it 'invalid when area is not present' do
        shed = create(:shed)

        shed.update(area: '')

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 2
        expect(shed.errors.full_messages.first).to eq 'Área não pode ficar em branco'
        expect(shed.errors.full_messages.last).to eq 'Área não é um número'
      end

      it 'invalid when address is not present' do
        shed = create(:shed)

        shed.update(address: '')

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Endereço não pode ficar em branco'
      end

      it 'invalid when postcode is not present' do
        shed = create(:shed)

        shed.update(postcode: '')

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 2
        expect(shed.errors.full_messages.first).to eq 'Código postal não pode ficar em branco'
        expect(shed.errors.full_messages.last).to eq 'Código postal deve ter o formato: 00000-000'
      end

      it 'invalid when description is not present' do
        shed = create(:shed)

        shed.update(description: '')

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Descrição não pode ficar em branco'
      end

      it 'invalid when code is already in use' do
        first_shed = create(:shed, code: 'ASU')
        second_shed = create(:shed, code: 'USA')

        second_shed.update(code: first_shed.code)

        expect(second_shed.errors.full_messages.length).to eq 1
        expect(second_shed.errors.full_messages.last).to eq 'Código já está em uso'
        expect(second_shed.reload.code).to eq 'USA'
      end

      it 'invalid when name is already in use' do
        first_shed = create(:shed, name: 'SP')
        second_shed = create(:shed, name: 'MG')

        second_shed.update(name: first_shed.name)

        expect(second_shed.errors.full_messages.length).to eq 1
        expect(second_shed.errors.full_messages.last).to eq 'Nome já está em uso'
        expect(second_shed.reload.name).to eq 'MG'
      end

      it 'invalid when the area is not greater than 20' do
        shed = create(:shed)

        shed.update(area: 1)

        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Área deve ser maior que 20'
      end

      it 'invalid when code length is not 3' do
        error_message = 'Código não possui o tamanho esperado (3 caracteres)'
        first_shed = create(:shed, code: 'SUV')
        second_shed = create(:shed, code: 'SEC')

        first_shed.update(code: 'ASUD')
        second_shed.update(code: 'AS')

        expect(first_shed.errors.full_messages.length).to eq 1
        expect(second_shed.errors.full_messages.length).to eq 1
        expect(first_shed.errors.full_messages.last).to eq error_message
        expect(second_shed.errors.full_messages.last).to eq error_message
      end

      it 'invalid when postcode does not match format' do
        shed = create(:shed, postcode: %w[01234-567 08652-300 78451-123].sample)

        shed.update(postcode: '451165415469')

        expect(shed).not_to be_valid
        expect(shed.errors.full_messages.length).to eq 1
        expect(shed.errors.full_messages.last).to eq 'Código postal deve ter o formato: 00000-000'
      end
    end
  end
end
