require 'rails_helper'

RSpec.describe 'Post Index Page', type: :feature do
    let(:user) { User.create(name: 'Tobias Boon', id: 1, post_counter: 1, bio: 'Bio text 1', photo: 'https://plus.unsplash.com/premium_photo-1690481529194-6087914e096e?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D' ) }
     
    let!(:post) { Post.create(title: 'First post', text: 'test text', author_id: user.id, comments_counter: 0) }
    let!(:post2) { Post.create(title: 'Second post', text: 'test text', author_id: user.id, comments_counter: 0, likes_counter: 0) }

    let!(:comment1) { Comment.create(user_id: user.id, post_id: post.id, text: 'First commment') }

    let!(:like) { Like.create(user_id: user.id, post_id: post.id) }

    it 'displays the user profile picture' do
      visit user_posts_path(user)
      expect(page).to have_css("img[src*='#{user.photo}']")
    end

    it 'displays the user username' do
      visit user_posts_path(user)
      expect(page).to have_content(user.name)
    end

    it 'displays the number of posts the user has written' do
      visit user_posts_path(user)
      expect(page).to have_content(user.post_counter)
    end

    it 'displays a posts title' do
      visit user_posts_path(user)
      expect(page).to have_content(post.title)
    end

    it 'displays some of the posts body' do
      visit user_posts_path(user)
      expect(page).to have_content(post.text)
    end
  
    it 'displays the first comments on a post' do
      visit user_posts_path(user)
      expect(page).to have_content('First post')
    end
  
    it 'displays how many comments a post has' do
      visit user_posts_path(user)
      expect(page).to have_content("Comments: #{post.comments_counter}")
    end
  
    it 'displays how many likes a post has' do
      visit user_posts_path(user)
      expect(page).to have_content("Likes: #{post.likes_counter}")
    end
  
    it 'displays a button for pagination' do
      visit user_posts_path(user)
      expect(page).to have_button("Pagination")
    end
  
    it 'redirects to a posts show page when clicking on a post' do
      visit user_posts_path(user)
      click_link 'First post'
      expect(current_path).to eq(user_post_path(user , post))
    end
end    