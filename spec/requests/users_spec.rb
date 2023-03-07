require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before do
      User.create!(name: 'Emmanuel', posts_counter: 0)
    end

    it 'Renders the index template' do
      get '/users'
      expect(response).to render_template(:index) 
    end
    
    it 'Renders the index template' do
      get '/users'
      expect(response).to be_successful 
    end

    it 'includes the user names in the response body' do
      get '/users'
      expect(response.body).to include('Here is a list of all user')
    end
  end

  describe "GET /users/:id" do
    let(:user) { User.create!(name: 'Emmanuel', posts_counter: 0) }

    it 'returns a successful response' do
      get "/users/#{user.id}"
      expect(response).to be_successful
    end

    it "renders the show template" do
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end

    it 'includes text in the response body' do
      get "/users/#{user.id}"
      expect(response.body).to include('Specific user')
    end
  end
end
