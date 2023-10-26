class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments

   #validations
   validates :title, presence: true
   validates :title, length: { maximum: 250 }
   validates :comments_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true}
   validates :likes_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true}
   
  # Callback
  after_save :updates_user_posts_counter

  # Methods
  def updates_user_posts_counter
    user.update(post_counter: user.posts.count)
  end

  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
