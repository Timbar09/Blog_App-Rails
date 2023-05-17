require 'rails_helper'

RSpec.describe 'Posts', type: :system, js: true do
  describe 'index page' do
    before(:example) do
      @messi = User.create(name: 'Messi', photo: 'https://i.imgur.com/messi.jpg',
                           bio: 'I love Barcelona and Argentina.')
      @cr7 = User.create(name: 'Cristiano', photo: 'https://i.imgur.com/cr7.jpg',
                         bio: 'I am ubleivable inside the pitch.')

      @messi_post1 = Post.create(title: 'First Post', text: 'This is the first post.', author: @messi)
      @messi_post2 = Post.create(title: 'Second Post', text: 'This is the second post.', author: @messi)
      @messi_post3 = Post.create(title: 'Third Post', text: 'This is the third post.', author: @messi)
      @messi_post4 = Post.create(title: 'Fourth Post', text: 'This is the fourth post.', author: @messi)

      @comment1 = Comment.create(text: 'Wassup G!.', author: @cr7, post: @messi_post2)
      @comment2 = Comment.create(text: "I'm not feeling too good, G!.", author: @messi, post: @messi_post2)
      @comment3 = Comment.create(text: 'How come, G?.', author: @cr7, post: @messi_post2)
      @comment4 = Comment.create(text: 'I miss Iniesta and xavi, G!.', author: @messi, post: @messi_post2)
      @comment5 = Comment.create(text: 'I miss Ramos and Marcelo, G!.', author: @cr7, post: @messi_post2)
      @comment6 = Comment.create(text: 'I miss the old days, G!.', author: @messi, post: @messi_post1)
      @comment7 = Comment.create(text: 'I miss the old days too, G!.', author: @cr7, post: @messi_post3)
      @comment8 = Comment.create(text: 'I miss the old days too, G!.', author: @messi, post: @messi_post4)

      visit user_posts_path(@messi)
    end

    it 'should render user profile information' do
      expect(page).to have_css("img[src*='messi.jpg']")
      expect(page).to have_content(@messi.name)
      expect(page).to have_content("Posts(#{@messi.posts_counter})")
    end

    it 'should render user posts' do
      expect(page).to have_css('.post_card', count: 4)
      @messi.posts.each do |post|
        expect(page).to have_link(post.title, href: user_post_path(@messi, post))
      end
    end

    it 'should render post information' do
      @messi.posts.each do |post|
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.text)
      end
    end

    it 'should render post interactions counts' do
      @messi.posts.each do |post|
        expect(page).to have_content("Comments(#{post.comments_counter})")
        expect(page).to have_content("Likes(#{post.likes_counter})")
      end
    end

    it 'should render the first comments on a post' do
      @messi.posts.each do |post|
        expect(page).to have_content(post.comments.first.text)
      end
    end

    it 'should redirect to post show page when clicking on post title' do
      click_link @messi_post1.title
      expect(page).to have_current_path(user_post_path(@messi, @messi_post1))
    end
  end

  describe 'post show page' do
    before(:example) do
      @messi = User.create(name: 'Messi', photo: 'https://i.imgur.com/messi.jpg',
                           bio: 'I love Barcelona and Argentina.')
      @cr7 = User.create(name: 'Cristiano', photo: 'https://i.imgur.com/cr7.jpg',
                         bio: 'I am ubleivable inside the pitch.')

      @messi_post = Post.create(title: 'First Post', text: 'This is the first post.', author: @messi)

      @comment1 = Comment.create(text: 'Wassup G!.', author: @cr7, post: @messi_post)
      @comment2 = Comment.create(text: "I'm not feeling too good, G!.", author: @messi, post: @messi_post)
      @comment3 = Comment.create(text: 'How come, G?.', author: @cr7, post: @messi_post)

      visit user_post_path(@messi, @messi_post)
    end

    it "should show post's title" do
      expect(page).to have_content(@messi_post.title)
    end
    it 'should show who wrote the post' do
      expect(page).to have_content("#{@messi_post.title} by #{@messi_post.author.name}")
    end
    it 'should show how many comments it has' do
      expect(page).to have_content("Comments(#{@messi_post.comments_counter}")
    end
    it 'should show how many likes it has' do
      expect(page).to have_content('Likes(0)')
    end
    it 'should show the post body' do
      expect(page).to have_content(@messi_post.text)
    end
    it 'should show the username of each commentor' do
      @messi_post.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end
    it 'should show the comment each commentor left' do
      @messi_post.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end
