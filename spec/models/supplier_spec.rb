# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe 'are there validations?' do
    context 'with presence' do
      it { is_expected.to validate_presence_of(:corporate_name) }
      it { is_expected.to validate_presence_of(:brand_name) }
      it { is_expected.to validate_presence_of(:registration_number) }
      it { is_expected.to validate_presence_of(:email) }
    end

    context 'with uniqueness' do
      subject { build(:supplier) }

      it { is_expected.to validate_uniqueness_of(:brand_name) }
      it { is_expected.to validate_uniqueness_of(:email) }
      it { is_expected.to validate_uniqueness_of(:registration_number).case_insensitive }
    end
  end

  describe '#valid?' do
    context 'with presence' do
      it 'valid when all fields are present' do
        supplier = described_class.new(attributes_for(:supplier))

        expect(supplier).to be_valid
      end

      it 'invalid when name is not present' do
        supplier = described_class.new(attributes_for(:supplier, corporate_name: ''))

        expect(supplier).not_to be_valid
        expect(supplier.errors.full_messages.length).to eq 1
        expect(supplier.errors.full_messages.last).to eq 'Nome Fantasia não pode ficar em branco'
      end

      it 'invalid when code is not present' do
        supplier = described_class.new(attributes_for(:supplier, brand_name: ''))

        expect(supplier).not_to be_valid
        expect(supplier.errors.full_messages.length).to eq 1
        expect(supplier.errors.full_messages.first).to eq 'Razão Social não pode ficar em branco'
      end

      it 'invalid when city is not present' do
        supplier = create(:supplier)

        supplier.update(registration_number: '')

        expect(supplier).not_to be_valid
        expect(supplier.errors.full_messages.length).to eq 2
        expect(supplier.errors.full_messages.first).to eq 'CNPJ não pode ficar em branco'
        expect(supplier.errors.full_messages.last).to eq 'CNPJ deve ter o formato: 00.000.000/0000-00'
      end

      it 'invalid when area is not present' do
        supplier = create(:supplier)

        supplier.update(email: '')

        expect(supplier).not_to be_valid
        expect(supplier.errors.full_messages.length).to eq 1
        expect(supplier.errors.full_messages.first).to eq 'E-mail não pode ficar em branco'
      end
    end

    context 'with uniqueness' do
      it 'invalid when brand_name is already in use' do
        first_supplier = create(:supplier)
        second_supplier = described_class.new(attributes_for(:supplier, brand_name: first_supplier.brand_name))

        expect(second_supplier).not_to be_valid
        expect(second_supplier.errors.full_messages.length).to eq 1
        expect(second_supplier.errors.full_messages.last).to eq 'Razão Social já está em uso'
      end

      it 'invalid when email is already in use' do
        first_supplier = create(:supplier)
        second_supplier = create(:supplier)

        second_supplier.update(email: first_supplier.email)

        expect(second_supplier).not_to be_valid
        expect(second_supplier.errors.full_messages.length).to eq 1
        expect(second_supplier.errors.full_messages.last).to eq 'E-mail já está em uso'
      end

      it 'invalid when registration_number is already in use' do
        first_supplier = create(:supplier)

        second_supplier =
          described_class.new(attributes_for(:supplier, registration_number: first_supplier.registration_number))

        expect(second_supplier).not_to be_valid
        expect(second_supplier.errors.full_messages.length).to eq 1
        expect(second_supplier.errors.full_messages.last).to eq 'CNPJ já está em uso'
      end
    end

    context 'with format validation' do
      it 'valid when phone_number matches format' do
        supplier = described_class.new(
          attributes_for(
            :supplier,
            phone_number: "(#{Faker::Number.number(digits: 2)}) "\
                          "#{Faker::Number.number(digits: 5)}-"\
                          "#{Faker::Number.number(digits: 4)}"
          )
        )

        expect(supplier).to be_valid
        expect(supplier.errors).to be_empty
      end

      it 'invalid when phone_number does not match format' do
        supplier = described_class.new(attributes_for(:supplier, phone_number: '451165415469'))

        expect(supplier).not_to be_valid
        expect(supplier.errors.full_messages.length).to eq 1
        expect(supplier.errors.full_messages.last).to eq 'Telefone deve ter o formato: (12) 12345-1234'
      end

      it 'valid when registration_number matches format' do
        supplier = described_class.new(
          attributes_for(
            :supplier,
            registration_number: Faker::Company.brazilian_company_number(formatted: true)
          )
        )

        expect(supplier).to be_valid
        expect(supplier.errors).to be_empty
      end

      it 'invalid when registration_number does not match format' do
        supplier = create(:supplier)

        supplier.update(registration_number: '0000000000')

        expect(supplier).not_to be_valid
        expect(supplier.errors.full_messages.length).to eq 1
        expect(supplier.errors.full_messages.last).to eq 'CNPJ deve ter o formato: 00.000.000/0000-00'
      end
    end
  end
end
