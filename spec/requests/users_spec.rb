require 'rails_helper'

RSpec.describe 'Users controller: ', type: :request do
  describe 'GET' do
    describe '/users/index' do
      it('returns a success response') do
        get users_path
        expect(response).to have_http_status(200)
      end

      it('renders the index template') do
        get users_path
        expect(response).to render_template(:index)
      end

      it('includes the placeholder text') do
        get users_path
        expect(response.body).to include('Users')
      end
    end

    describe '/show' do
      before(:each) do
        @user = User.create(name: 'Miles', photo: 'https://i.imgur.com/1.jpg', bio: 'I am a test user.')

        get user_path(@user)
      end

      it('returns a success response') do
        expect(response).to have_http_status(200)
      end

      it('renders the show template') do
        expect(response).to render_template(:show)
      end

      it('includes the placeholder text') do
        expect(response.body).to include('I am a test user.')
      end
    end
  end
end
