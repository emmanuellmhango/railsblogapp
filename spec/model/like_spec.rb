require 'rails_helper'

RSpec.describe Like, type: :model do
  test_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                          posts_counter: 0)
  test_post = Post.create(
    author_id: test_user.id,
    title: 'Hello',
    text: 'This is my first post',
    comments_counter: 0,
    likes_counter: 1
  )
  subject { Like.new(author_id: test_user.id, post_id: test_post.id) }
  before { subject.save }
  it 'Like counter for post must be incremented by 1' do
    expect(subject.post.likes_counter).to eql(1)
  end
end
