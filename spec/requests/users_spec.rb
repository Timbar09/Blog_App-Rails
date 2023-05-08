require 'rails_helper'

RSpec.describe 'Users controller: ', type: :request do
  describe 'GET' do
    describe '/users/index' do
      it ('returns a success response') do
        get users_path
        expect(response).to have_http_status(200)
      end
  
      it ('renders the index template') do
        get users_path
        expect(response).to render_template(:index)
      end
  
      it ('includes the placeholder text') do
        get users_path
        expect(response.body).to include('List of all users')
      end
    end

    describe '/show' do
      it ('returns a success response') do
        get user_path(340)
        expect(response).to have_http_status(200)
      end
  
      it ('renders the show template') do
        get user_path(340)
        expect(response).to render_template(:show)
      end
  
      it ('includes the placeholder text') do
        get user_path(340)
        expect(response.body).to include('User profile')
      end
    end
  end
end
