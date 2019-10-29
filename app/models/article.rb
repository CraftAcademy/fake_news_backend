class Article < ApplicationRecord
  validates_presence_of :title, :content
  validates :title, length: { minimum: 3, maximum: 50 }
  validates :content, length: { minimum: 10, maximum: 250 }
  has_one_attached :image
end
