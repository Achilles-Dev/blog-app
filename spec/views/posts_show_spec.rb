require 'rails_helper'

RSpec.describe 'PostsShowPages', type: :system do
  before do
    driven_by(:rack_test)
  end

  before(:each) do
    @user = User.create!(name: 'Sam', bio: 'Full stack developer', email: 'sam@gmail.com',
                         password: 'sam22021', post_counter: 0, confirmed_at: Time.now)

    # login_as @user
    @user2 = User.create!(name: 'Solomon', bio: 'Full stack developer', post_counter: 0,
                          email: 'user2@example.com', password: 'password2', confirmed_at: Time.now)
    (1..6).each do |n|
      post = Post.create(user_id: @user2.id, title: "Post #{n}", text: "Post content #{n}",
                         comments_counter: 0, likes_counter: 0)
      post.counter_updater
    end
    @user2.posts.each do |post|
      comment = Comment.create(post:, user: @user, text: 'Hi Tom!')
      comment.counter_updater
    end
    @post = @user2.posts.first
    visit "/users/#{@user2.id}/posts/#{@post.id}"
  end

  describe 'Page content' do
    it 'should have name of who wrote the post' do
      expect(page).to have_content(@user2.name)
    end
    it "should display a posts's title" do
      expect(page).to have_content(@post.title)
    end
    it "should display a posts's body" do
      expect(page).to have_content(@post.text)
    end
    it "should display a post's comments count" do
      expect(page).to have_content("Comments: #{@post.comments_counter}")
    end
    it "should display a post's likes count" do
      expect(page).to have_content("Likes: #{@post.likes_counter}")
    end
    it 'should display username of each commentor on a post' do
      expect(page).to have_content("#{@user.name}:")
    end
    it 'should display username of each commentor on a post' do
      comment = @post.comments.where(user_id: @user).first
      expect(page).to have_content(comment.text)
    end
  end
end
