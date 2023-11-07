require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  let(:user) { User.create(name: 'Tobias Boon', id: 1, post_counter: 1, bio: 'Bio text 1', photo: 'https://plus.unsplash.com/premium_photo-1690481529194-6087914e096e?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D') }
  let!(:post) do
    Post.create(title: 'First post', text: 'test text', author_id: user.id, comments_counter: 5, likes_counter: 0)
  end
  let!(:post2) do
    Post.create(title: 'Second post', text: 'test text', author_id: user.id, comments_counter: 0, likes_counter: 0)
  end
  let!(:comment1) { Comment.create(user_id: user.id, post_id: post.id, text: 'First commment') }
  let!(:comment2) { Comment.create(user_id: user.id, post_id: post.id, text: 'Second commment') }
  let!(:comment3) { Comment.create(user_id: user.id, post_id: post.id, text: 'Third commment') }
  let!(:comment4) { Comment.create(user_id: user.id, post_id: post.id, text: 'Fourth commment') }
  let!(:comment5) { Comment.create(user_id: user.id, post_id: post.id, text: 'Fifth commment') }

  it 'Display posts title' do
    visit user_post_path(user, post)
    expect(page).to have_content(post.title)
  end

  it 'Display who wrote the post' do
    visit user_post_path(user, post)
    expect(page).to have_content("by #{user.name}")
  end

  it 'Display how many comments it has' do
    visit user_post_path(user, post)
    expect(page).to have_content("Comments: #{post.comments_counter}")
  end

  it 'Display how many likes it has' do
    visit user_post_path(user, post)
    expect(page).to have_content("Likes: #{post.likes_counter}")
  end

  it 'Display the post body' do
    visit user_post_path(user, post)
    expect(page).to have_content(post.text)
  end

  describe 'Display the username and comment of each commentor' do
    before do
      user_test1 = User.create(name: 'John Doe', id: 3, post_counter: 1, bio: 'Bio text 1', photo: '...')
      user_test2 = User.create(name: 'Miguel Angel', id: 4, post_counter: 1, bio: 'Bio text 1', photo: '...')
      post_test = Post.create(title: 'First post', text: 'test text', author_id: user_test1.id, comments_counter: 5,
                              likes_counter: 0)
      Comment.create(user_id: user_test1.id, post_id: post_test.id, text: 'First comment')
      Comment.create(user_id: user_test2.id, post_id: post_test.id, text: 'Second comment')
      visit user_post_path(user_test1, post_test)
    end

    it 'displays the username of each commentor' do
      expect(page).to have_content('John Doe')
      expect(page).to have_content('Miguel Angel')
    end

    it 'displays the comment each commentor left' do
      expect(page).to have_content('First comment')
      expect(page).to have_content('Second comment')
    end
  end
end
