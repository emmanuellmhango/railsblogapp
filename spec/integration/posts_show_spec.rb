require 'rails_helper'

RSpec.describe 'Post Page Index', type: :feature do
  before :each do
    @user1 = User.create(
      name: 'Emmanuel',
      photo: 'https://static.freeimages.com/images/home/filetypes/photo.png',
      bio: 'Full-Stack Engineer',
      posts_counter: 0
    )
    @user2 = User.create(
      name: 'Benjamin',
      photo: 'https://static.freeimages.com/images/home/filetypes/photo.png',
      bio: 'Frontend Developer',
      posts_counter: 0
    )
    @post = Post.create(author_id: @user1.id, title: 'Post One', text: 'This is my first post!', comments_counter: 0,
                        likes_counter: 0)
    Comment.create(post_id: @post.id, author_id: @user1.id, text: 'My comment 1!')
    Comment.create(post_id: @post.id, author_id: @user2.id, text: 'My comment 2!')
    visit user_posts_path(@user1.id)
  end

  it 'should have the username of the user' do
    expect(page).to have_content(@post.title)
  end

  it 'should have the writer of the post' do
    expect(page).to have_content("#{@user.name}:")
  end

  it 'should have the number of comments for the post' do
    expect(page).to have_content('Comments: 2')
  end

  it 'should have the number of likes for the post' do
    expect(page).to have_content('Likes: 0')
  end

  it 'should have the body of the post' do
    expect(page).to have_content('This is my first post!')
  end

  it 'should have the username of each commentor' do
    expect(page).to have_content('Benjamin')
  end

  it 'should have the comment of each commentor' do
    expect(page).to have_content('My comment 1!')
  end
end
