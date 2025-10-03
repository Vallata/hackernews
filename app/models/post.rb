class Post < ApplicationRecord
  has_many :votes, dependent: :destroy
  validates :title, presence: true, uniqueness: true
  validates :url, presence: true
  validates :post_type, presence: true
  validates :post_author, presence: true
  validates :score, presence: true
  belongs_to :user, optional: true
end
