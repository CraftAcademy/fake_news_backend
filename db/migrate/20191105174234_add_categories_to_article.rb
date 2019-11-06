class AddCategoriesToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :categories, :string
  end
end
