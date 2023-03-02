require 'rails_helper'

RSpec.describe Post, type: :model do
  test_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                          posts_counter: 0)
  test_post = Post.create(
    author_id: test_user.id,
    title: 'Hello',
    text: 'This is my first post',
    comments_counter: 1,
    likes_counter: 0
  )
  subject { Comment.new(author_id: test_user.id, post_id: test_post.id, text: 'This is a comment for post') }
  before { subject.save }
  it 'Comment counter for post must be incremented' do
    expect(subject.post.comments_counter).to eql(1)
  end
end
