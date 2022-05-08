class AddUniqueIndexToShed < ActiveRecord::Migration[7.0]
  def change
    change_column :sheds, :code, :string
    add_index :sheds, :code, unique: true
  end
end
