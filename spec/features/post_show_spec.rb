RSpec.describe 'Post show page', type: :feature do
    let(:user) { User.create(name: 'Tobias Boon', id: 1, post_counter: 1, bio: 'Bio text 1', photo: 'https://plus.unsplash.com/premium_photo-1690481529194-6087914e096e?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D' ) }
    let!(:post) { Post.create(title: 'First post', text: 'test text', author_id: user.id, comments_counter: 5, likes_counter: 0) }
    let!(:post2) { Post.create(title: 'Second post', text: 'test text', author_id: user.id, comments_counter: 0, likes_counter: 0) }
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

    it 'Displat the post body' do
        visit user_post_path(user, post)
        expect(page).to have_content(post.text)
    end
end