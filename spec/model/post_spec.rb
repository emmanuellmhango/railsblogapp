require 'rails_helper'

RSpec.describe Post, type: :model do
  test_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
                          posts_counter: 0)
  subject do
    Post.new(
      author_id: test_user.id,
      title: 'Hello',
      text: 'This is my first post',
      comments_counter: 0,
      likes_counter: 0
    )
  end
  before { subject.save }

  it 'Title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'comments_counter to be >= 0 always' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Post counter for user must be incremented by one' do
    expect(subject.user.posts_counter).to eql(1)
  end

  it 'title maximum 250 chars' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end
end
