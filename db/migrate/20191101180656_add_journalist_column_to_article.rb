class AddJournalistColumnToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :journalist_id, :integer
  end
end
