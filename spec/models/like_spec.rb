require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#updates_post_likes_counter' do
    it 'should update post likes counter to 2' do
      user = User.create(name: 'Jonh Doe', post_counter: 0)
      post = Post.create(title: 'post1', author_id: user.id, comments_counter: 0, likes_counter: 0)
      Like.create(user_id: user.id, post_id: post.id)
      like2 = Like.create(user_id: user.id, post_id: post.id)

      like2.updates_post_likes_counter

      expect(post.reload.likes_counter).to eq(2)
    end
  end
end
