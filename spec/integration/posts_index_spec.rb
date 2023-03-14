require 'rails_helper'

RSpec.describe 'Post Index', type: :feature do
  before :each do
    @user = User.create(
      name: 'Benjamin',
      photo: 'https://static.freeimages.com/images/home/filetypes/photo.png',
      bio: 'Software Engineer',
      posts_counter: 0
    )
    @post = Post.create(author_id: @user.id, title: 'Post One', text: 'This is my first post!', comments_counter: 0,
                        likes_counter: 0)
    @post = Post.create(author_id: @user.id, title: 'Post Two', text: 'This is my second post!', comments_counter: 0,
                        likes_counter: 0)
    Comment.create(post_id: @post.id, author_id: @user.id, text: 'Comment 1!')
    Comment.create(post_id: @post.id, author_id: @user.id, text: 'Comment 2!')
    visit user_posts_path(@user.id)
  end

  it 'should have the profile picture of the user' do
    assert page.has_xpath?("//img[@src='https://static.freeimages.com/images/home/filetypes/photo.png']")
  end

  it 'should have the username of the user' do
    expect(page).to have_content(@user.name)
  end

  it 'should have the number of posts of the user' do
    expect(page).to have_content('Number of posts: 2')
  end

  it 'should have the title of a post' do
    expect(page).to have_content(@post.title)
  end

  it 'should have the body of a post' do
    expect(page).to have_content('This is my first post!')
  end

  it 'should have the first comments of a post' do
    expect(page).to have_content('Comment 1!')
  end

  it 'should have the number of comments for a post' do
    expect(page).to have_content('Comments: 2')
  end

  it 'should have the number of likes for a post' do
    expect(page).to have_content('Likes: 0')
  end

  it 'should have the body of a post' do
    expect(page).to have_content('This is my first post!')
  end
  it 'should redirect to posts show page' do
    click_on 'Post One'
    expect(page).to have_current_path user_post_path(@user.id, @post.id)
  end
end
