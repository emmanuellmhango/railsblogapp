require 'rails_helper'

RSpec.describe 'User Index', type: :feature do
  before :each do
    @user1 = User.create(
      name: 'Emmanuel',
      photo: 'https://static.freeimages.com/images/home/filetypes/photo.png',
      bio: 'Full Stack',
      posts_counter: 1
    )
    @user2 = User.create(
      name: 'Benjamic',
      photo: 'https://static.freeimages.com/images/home/filetypes/photo.png',
      bio: 'Software Engineer',
      posts_counter: 2
    )
    visit root_path
  end

  it 'should have the username of all users' do
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end

  it 'should have the users number of posts' do
    expect(page).to have_content('Number of posts: 1')
    expect(page).to have_content('Number of posts: 2')
  end

  it 'should redirect to that users show page on click' do
    click_link(@user1.name)
    expect(page).to have_current_path user_path(@user1.id)
  end
end
