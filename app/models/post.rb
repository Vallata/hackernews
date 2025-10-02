class Post < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
  validates :post_type, presence: true
  validates :post_author, presence: true
  validates :score, presence: true
end
