class RemoveCategoryAddKey < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :category
    add_reference :articles, :category, foreign_key: true
  end
end
