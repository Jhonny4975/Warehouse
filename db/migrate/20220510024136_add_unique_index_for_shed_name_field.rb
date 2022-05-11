class AddUniqueIndexForShedNameField < ActiveRecord::Migration[7.0]
  def change
    change_column :sheds, :name, :string
    add_index :sheds, :name, unique: true
  end
end
