class RenameCategoryToName < ActiveRecord::Migration[6.0]
  def change
    rename_column :categories, :category, :name
    remove_column :categories, :article_id
  end
end
