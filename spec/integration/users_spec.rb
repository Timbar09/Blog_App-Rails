require 'rails_helper'

RSpec.describe 'Users', type: :system, js: true do
  describe 'index page' do
    before(:example) do
      @user = User.create(name: 'Miles', photo: 'https://i.imgur.com/1.jpg', bio: 'I am a test user.')
      @user2 = User.create(name: 'John', photo: 'https://i.imgur.com/2.jpg', bio: 'I am a second test user.')
      visit users_path
    end

    it 'should render a list of users' do
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user2.name)
    end

    it 'should render a profile picture for each user' do
      expect(page).to have_css("img[src*='1.jpg']")
      expect(page).to have_css("img[src*='2.jpg']")
    end

    it 'should render the number of posts for each user' do
      expect(page).to have_content('Posts(0)')
    end

    it 'should redirect to the user page when a user is clicked' do
      find('.user_card', text: @user.name).click
      expect(page).to have_current_path(user_path(@user))
    end
  end

  describe 'show page' do
    before(:example) do
      @user = User.create(name: 'Cristiano', photo: 'https://i.imgur.com/3.jpg',
                          bio: 'I am ubleivable inside the pitch.')
      @post1 = Post.create(title: 'First Post', text: 'This is the first post.', author: @user)
      @post2 = Post.create(title: 'Second Post', text: 'This is the second post.', author: @user)
      @post3 = Post.create(title: 'Third Post', text: 'This is the third post.', author: @user)
      @post4 = Post.create(title: 'Fourth Post', text: 'This is the fourth post.', author: @user)
      @post5 = Post.create(title: 'Fifth Post', text: 'This is the fifth post.', author: @user)
      visit user_path(@user)
    end

    it 'shows the user profile information' do
      expect(page).to have_css("img[src*='3.jpg']")
      expect(page).to have_content(@user.name)
      expect(page).to have_content("Posts(#{@user.posts_counter})")
      expect(page).to have_content(@user.bio)
    end

    it 'shows the first 3 posts' do
      expect(page).to have_css('.post_card', count: 3)
      @user.three_recent_posts.each do |post|
        expect(page).to have_link(post.title, href: user_post_path(@user, post))
      end
    end

    it 'shows a button to view all posts' do
      expect(page).to have_link('See all posts', href: user_posts_path(@user))
    end

    it 'redirects to post show page when clicking on a post' do
      click_link @post5.title
      expect(page).to have_current_path(user_post_path(@user, @post5))
    end

    it 'redirects to user posts index page when clicking on view all posts button' do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end
