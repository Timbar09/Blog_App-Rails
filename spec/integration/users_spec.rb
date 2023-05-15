require 'rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  describe 'index' do
    before(:example) do
      user = User.create(name: 'Miles', photo: 'https://i.imgur.com/1.jpg', bio: 'I am a test user.')
      user2 = User.create(name: 'John', photo: 'https://i.imgur.com/2.jpg', bio: 'I am a second test user.')
      visit users_path
    end

    it 'renders a list of users' do
      expect(page).to have_content('Miles')
      expect(page).to have_content('John')
    end

    it 'renders a profile picture for each user' do
      expect(page).to have_css("img[src*='1.jpg']")
      expect(page).to have_css("img[src*='2.jpg']")
    end

    it 'renders the number of posts for each user' do
      expect(page).to have_content('Posts(0)')
    end

    it 'should redirect to the user page when a user is clicked' do
      click_link 'Miles'
      expect(page).to have_current_path(users_path(@user))
    end
  end
end