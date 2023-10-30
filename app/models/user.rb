class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  # Validations
  validates :name, presence: true
  validates :post_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  # Method
  def three_most_recent_post
    posts.order(created_at: :desc).limit(3)
  end
end