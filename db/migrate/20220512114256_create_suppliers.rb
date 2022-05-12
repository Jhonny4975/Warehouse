# frozen_string_literal: true

class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :corporate_name, null: false
      t.string :brand_name, index: { unique: true, name: 'unique_brand_names' }, null: false
      t.string :registration_number, index: { unique: true, name: 'unique_registration_numbers' }, null: false
      t.string :street_address
      t.string :city
      t.string :state
      t.string :email, index: { unique: true, name: 'unique_emails' }, null: false
      t.string :phone_number

      t.timestamps
    end
  end
end
