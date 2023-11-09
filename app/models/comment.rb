class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # Callback
  after_save :update_comments_counter
  after_destroy :update_comments_counter

  # Methods
  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
