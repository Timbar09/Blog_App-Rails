require 'rails_helper'

RSpec.describe 'Posts controller: ', type: :request do
  describe 'GET' do
    describe '/posts/index' do
      before(:each) do
        @test_user = User.create(name: 'Miles', photo: 'https://i.imgur.com/1.jpg', bio: 'I am a test user.')
        get user_posts_path(@test_user)
      end

      it ('returns a success response') do
        expect(response).to have_http_status(200)
      end

      it ('renders the index template') do
        expect(response).to render_template(:index)
      end

      it ('includes the placeholder text') do
        expect(response.body).to include("Posts by #{@test_user[:name]}")
      end
    end

    describe '/posts/show' do
      before(:each) do
        @user = User.create(name: 'Miles', photo: 'https://i.imgur.com/1.jpg', bio: 'I am a test user.')
        puts "test user id: #{@user[:id]}"

        @post = Post.create(author: @user, title: 'Test Post', text: 'This is a test post.')
        puts "test post id: #{@post[:id]}"

        get user_post_path(@user, @post)
      end

      it ('returns a success response') do
        expect(response).to have_http_status(200)
      end

      it ('renders the show template') do
        expect(response).to render_template(:show)
      end

      it ('includes the placeholder text') do
        expect(response.body).to include('Test Post')
      end
    end
  end
end