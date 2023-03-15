require 'rails_helper'
RSpec.describe 'User Page Index', type: :feature do
  before :each do
    @user = User.create(
      name: 'Emmanuel',
      photo: 'https://static.freeimages.com/images/home/filetypes/photo.png',
      bio: 'Full-Stack Engineer',
      posts_counter: 0
    )
    @post1 = Post.create(title: 'My Post 1', text: 'This is my first post', comments_counter: 0,
                         likes_counter: 0, author_id: @user.id)
    @post2 = Post.create(title: 'My Post 2', text: 'This is my second post!', comments_counter: 0,
                         likes_counter: 0, author_id: @user.id)
    visit user_path(@user.id)
  end

  it 'should have the profile picture of the user' do
    assert page.has_xpath?("//img[@src = 'https://static.freeimages.com/images/home/filetypes/photo.png']")
  end

  it 'should have the username' do
    expect(page).to have_content(@user.name)
  end

  it 'should have the number of posts written by user' do
    expect(page).to have_content('Number of posts: 2')
  end

  it 'should have the users bio' do
    expect(page).to have_content('Full-Stack Engineer')
  end

  it 'should have the first three posts of user' do
    expect(page).to have_content(@post1.text)
    expect(page).to have_content(@post2.text)
  end

  it 'should have a button for seeing all posts' do
    expect(page).to have_link('See All Posts')
  end

  it 'should redirect to all user posts index page on click' do
    click_link('See All Posts')
    expect(page).to have_current_path user_posts_path(@user.id)
  end

  it 'redirect to user post click' do
    click_link(@post1.text)
    expect(page).to have_current_path(user_post_url(user_id: @user.id, id: @post1.id))
  end
end
