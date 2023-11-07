require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create(name: 'Jonh Doe', id: 1, post_counter: 0, photo: 'https://plus.unsplash.com/premium_photo-1690481529194-6087914e096e?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D') }
  let(:post) { Post.create(title: 'Test post', author_id: user.id, comments_counter: 0, likes_counter: 0) }

  describe 'GET #index' do
    before do
      get user_posts_path(user)
    end

    it 'response status was correct' do
      expect(response).to have_http_status(:success)
    end

    it 'correct template was rendered' do
      expect(response).to render_template(:index)
    end

    it 'response body includes correct placeholder text' do
      expect(response.body).to include(user.name)
    end
  end

  describe 'GET #show' do
    before do
      get user_post_path(user, post)
    end

    it 'response status was correct' do
      expect(response).to have_http_status(:success)
    end

    it 'correct template was rendered' do
      expect(response).to render_template(:show)
    end
  end
end
