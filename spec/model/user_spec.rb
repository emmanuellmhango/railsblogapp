require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }
  before { subject.save }

  it 'Name should be set' do
    expect(subject.name).to eq('Tom')
  end

  it 'posts_counter must be integer' do
    subject.posts_counter = 1.2
    expect(subject).to_not be_valid
  end
end
