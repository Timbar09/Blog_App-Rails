require 'rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  let(:user) { create(:user) }

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

  describe "show" do
    let(:user) { create(:user) }
    before do
      create_list(:post, 5, user: user)
      visit user_path(user)
    end

    it 'shows the user profile information' do
      expect(page).to have_css("img[src*='#{user.profile_picture_url}']")
      expect(page).to have_content(user.username)
      expect(page).to have_content("Number of Posts: #{user.posts.count}")
      expect(page).to have_content(user.bio)
    end
  
    it 'shows the first 3 posts' do
      expect(page).to have_css('.post', count: 3)
      user.three_recent_posts.each do |post|
        expect(page).to have_link(post.title, href: post_path(post))
      end
    end
  
    it 'shows a button to view all posts' do
      expect(page).to have_link('View All Posts', href: user_posts_path(user))
    end
  
    it 'redirects to post show page when clicking on a post' do
      post = user.posts.first
      click_link post.title
      expect(current_path).to eq(post_path(post))
    end
  
    it 'redirects to user posts index page when clicking on view all posts button' do
      click_link 'View All Posts'
      expect(current_path).to eq(user_posts_path(user))
    end
  end
end