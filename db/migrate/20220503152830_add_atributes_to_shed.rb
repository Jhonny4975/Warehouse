class AddAtributesToShed < ActiveRecord::Migration[7.0]
  def change
    add_column :sheds, :address, :string
    add_column :sheds, :postcode, :string
    add_column :sheds, :description, :string
  end
end
