class RenameCategoriesToCategory < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :categories, :category
  end
end
