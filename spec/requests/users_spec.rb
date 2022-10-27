require 'rails_helper'

RSpec.describe UsersController, type: :request do
  subject { User.create(name: 'Alan Luqman', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from UK.', post_counter: 0) }

  describe 'GET#index' do
    before(:example) do
      get '/users'
    end

    it 'responds success' do
      expect(response).to have_http_status(:ok)
    end

    it 'rendering index success' do
      expect(response).to render_template(:index)
    end

    it 'render index correctly' do
      expect(response.body).to include('List of Users')
    end
  end

  describe 'GET#show' do
    before(:example) do
      get "/users/#{subject.id}"
    end

    it 'responds success' do
      expect(response).to have_http_status(:ok)
    end

    it 'render show user' do
      expect(response).to render_template(:show)
    end

    it 'render user with spesific id' do
      expect(response.body).to include('User Details')
    end
  end
end
