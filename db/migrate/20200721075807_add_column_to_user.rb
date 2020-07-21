class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :language, :string
  end
end
