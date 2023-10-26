require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#updates_comments_counter' do
    it 'should update comments counter' do
      user = User.create(name: 'John Doe', post_counter: 0)
      post = Post.create(title: 'post1', author_id: user.id, comments_counter: 0, likes_counter: 0)
      Comment.create(user_id: user.id, post_id: post.id)
      comment2 = Comment.create(user_id: user.id, post_id: post.id)

      comment2.updates_comments_counter

      expect(post.reload.comments_counter).to eq(2)
    end
  end
end
