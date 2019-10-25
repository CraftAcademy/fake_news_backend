class Article < ApplicationRecord
  validates_presence_of :title, :content
  has_one_attached :image
end
