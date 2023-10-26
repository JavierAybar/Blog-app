require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John', post_counter: 0) }

  subject { Post.new(title: 'title', comments_counter: 0, likes_counter: 0, author_id: user.id) }

  before { subject.save }

  describe 'validations' do
    it 'Title must not be blank' do
      subject.title = 'test'
      expect(subject).to be_valid
    end

    it 'Title must not exceed 250 characters' do
      subject.title = 'q' * 249
      expect(subject).to be_valid
    end

    it 'comments_counter must be an integer greater than or equal to zero' do
      subject.comments_counter = -2
      expect(subject).to_not be_valid
    end

    it 'likes_counter must be an integer greater than or equal to zero' do
      subject.likes_counter = -2
      expect(subject).to_not be_valid
    end
  end

  describe '#updates_user_posts_counter' do
    it 'should update user post counter to 2' do
      user = User.create(name: 'Jonh Doe', post_counter: 0)
      Post.create(title: 'post1', author_id: user.id, comments_counter: 0, likes_counter: 0)
      post2 = Post.create(title: 'post2', author_id: user.id, comments_counter: 0, likes_counter: 0)

      post2.updates_user_posts_counter

      expect(user.reload.post_counter).to eq(2)
    end
  end

  describe '#five_most_recent_comments' do
    it 'should return 5 most recent comments' do
      user = User.create(name: 'Jonh Doe', post_counter: 0)
      post = Post.create(title: 'post1', author_id: user.id, comments_counter: 0, likes_counter: 0)
      Comment.create(user_id: user.id, post_id: post.id)
      comment2 = Comment.create(user_id: user.id, post_id: post.id)
      comment3 = Comment.create(user_id: user.id, post_id: post.id)
      comment4 = Comment.create(user_id: user.id, post_id: post.id)
      comment5 = Comment.create(user_id: user.id, post_id: post.id)
      comment6 = Comment.create(user_id: user.id, post_id: post.id)

      recent_comments = post.five_most_recent_comments

      expect(recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
    end
  end
end
