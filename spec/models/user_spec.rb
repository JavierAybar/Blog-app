require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe') }

  before { subject.save }

  describe '#validations' do
    it 'name muts not be blank' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'PostsCounter must be an integer greater than or equal to zero' do
      subject.post_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe '#three_most_recent_post' do
    it 'should return three most recent posts' do
      user = User.create(name: 'Jonh Doe', post_counter: 0)
      Post.create(title: 'post1', author_id: user.id, comments_counter: 0, likes_counter: 0)
      post2 = Post.create(title: 'post2', author_id: user.id, comments_counter: 0, likes_counter: 0)
      post3 = Post.create(title: 'post3', author_id: user.id, comments_counter: 0, likes_counter: 0)
      post4 = Post.create(title: 'post4', author_id: user.id, comments_counter: 0, likes_counter: 0)

      recents_posts = user.three_most_recent_post

      expect(recents_posts).to eq([post4, post3, post2])
    end
  end
end
