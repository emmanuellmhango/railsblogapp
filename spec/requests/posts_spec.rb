require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    let(:user) { User.create!(name: 'Emmanuel', posts_counter: 0) }

    before do
      Post.create!(title: 'Post 1', author_id: user.id, likes_counter: 0, comments_counter: 0)
      Post.create!(title: 'Post 2', author_id: user.id, likes_counter: 0, comments_counter: 0)
    end

    it'returns a successful response' do
      get "/users/#{user.id}/posts"
      expect(response).to be_successful
    end

    it'returns a successful response' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end

    it'includes the text from the body' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET /show' do 
    let(:user) { User.create!(name: 'Emmanuel', posts_counter: 0) }
    let(:post) { Post.create!(title: 'Post 1', author_id:user.id, likes_counter: 0, comments_counter: 0) }

    it 'returns a successful response' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to be_successful
    end

    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end

    it 'includes the post page test in the response body' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include('Specific post')
    end
  end
end
