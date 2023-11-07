require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before do
    User.create(
      name: 'Jonh Doe',
      id: 1,
      post_counter: 2,
      photo: 'https://plus.unsplash.com/premium_photo-1690481529194-6087914e096e?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    )

    User.create(
      name: 'Tobias Boon',
      id: 2,
      post_counter: 3,
      photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    )
    
  end

  it 'displays usernames of all other users' do
    visit users_path
    expect(page).to have_content('Jonh Doe')
  end

  it 'displays profile picture for each user' do
    visit users_path
    expect(page).to have_css("img[src*='https://plus.unsplash.com/premium_photo-1690481529194-6087914e096e?auto=format&fit=crop&q=80&w=1974&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D']")
    expect(page).to have_css("img[src*='https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D']")
  end

  it 'displays the number of posts each user has written' do
    visit users_path
    expect(page).to have_content('Number of post: 3')
    expect(page).to have_content('Number of post: 2')
  end

  it 'redirects to user show page when clicking on a user' do
    visit users_path
    click_link('Tobias Boon')
    expect(current_path).to eq(user_path(User.last))
  end
end