require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { User.create(name: 'Jonh Doe', id: 1, post_counter: 0, photo: 'https://plus.unsplash.com/premium_photo-1690481529194-6087914e096e?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D') }

  describe 'GET #index' do
    it 'response status was correct' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'correct template was rendered' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'response body includes correct placeholder text' do
      get users_path
      expect(response.body).to include('BlogApp')
    end
  end

  describe 'GET #show' do
    it 'response status was correct' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'correct template was rendered' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'response body includes correct placeholder text' do
      get user_path(user)
      expect(response.body).to include('bio-container')
    end
  end
end
