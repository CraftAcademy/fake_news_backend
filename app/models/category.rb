class Category < ApplicationRecord
  validates :category, presence: true
  validates :article_id, presence: true

  has_many :articles
  
end