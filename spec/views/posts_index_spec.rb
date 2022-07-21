require 'rails_helper'

RSpec.describe 'posts/index.html.erb', type: :feature do
  before(:each) do
    visit new_user_session_path
    @user = User.new(name: 'Sam', bio: 'Full stack developer', email: 'sam@gmail.com', password: 'sam22021',
                     post_counter: 1, confirmed_at: Time.now)
    @user.save
    (1..5).each do |n|
      post = Post.create(title: "First post #{n}", text: 'Post content', user_id: @user.id, comments_counter: 0,
                         likes_counter: 0)
      post.counter_updater
    end
    fill_in 'user[email]', with: 'sam@gmail.com'
    fill_in 'user[password]', with: 'sam'
    visit(user_posts_path(@user.id))
    @post = @user.posts.last
  end

  it "Shows user's name" do
    expect(page).to have_content @user.name
  end

  it "shows user's profile picture" do
    all('img').each do |i|
      expect(i[:alt]).to eq('Profile')
    end
  end

  it 'shows number of posts for the user' do
    expect(page).to have_content('Number of posts: 5')
  end

  it "shows see a post's title" do
    expect(page).to have_content('Sam')
  end

  it "shows some of the post's body" do
    expect(page).to have_content Post.first.text
  end

  it 'shows the first comment on a post' do
    Comment.create(text: 'first comment', user_id: @user.id, post_id: Post.first.id)
    visit(user_posts_path(@user.id))
    expect(page).to have_content Comment.first.text
  end

  it 'shows a section for pagination if there are more posts than fit on the view.' do
    expect(page).to have_content('Pagination')
  end

  it 'should see how many likes a post has' do
    expect(page).to have_content 'Likes: 0'
  end

  it "click on user's post should redirect to post's show page" do
    click_link 'First post 5'
    expect(current_path).to eq user_post_path(@user, @post)
  end
end
