require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before :each do
    @user1 = User.create!(name: 'Oybek', bio: 'Programmer', post_counter: 0, email: 'user@example.com',
                          password: 'password', confirmed_at: '2022-07-19 22:25:13.71382')
    @post1 = Post.create!(title: 'Post 1', text: 'This is my first post', user_id: @user1.id, comments_counter: 0,
                          likes_counter: 0)
    @post2 = Post.create!(title: 'post 2', text: 'This is my second post', user_id: @user1.id, comments_counter: 0,
                          likes_counter: 0)
    @post3 = Post.create!(title: 'Post 3', text: 'This is my third post', user_id: @user1.id, comments_counter: 0,
                          likes_counter: 0)
    @post4 = Post.create!(title: 'Post 4', text: 'This is my last post', user_id: @user1.id, comments_counter: 0,
                          likes_counter: 0)
    @post4.counter_updater
  end

  it 'can see the the profile image for a user' do
    visit user_path(@user1)
    expect(page).to have_css("img[alt='Profile']")
  end

  it "can see the user's username" do
    visit user_path(@user1)
    expect(page).to have_content 'Oybek'
  end

  it 'can see the number of posts for the user' do
    visit user_path(@user1)
    expect(page).to have_content('Number of posts: 4')
  end

  it "can see the user's bio" do
    visit user_path(@user1)
    expect(page).to have_content('Programmer')
  end

  it "can see the user's first three posts" do
    visit user_path(@user1)
    expect(@user1.recent_posts.length).to eq(3)
  end

  it "can see a link that lets me view all of a user's posts." do
    visit user_path(@user1)
    expect(page).to have_link('See all posts')
  end

  it "click on user's post to redirect to post's show page" do
    visit user_path(@user1)
    click_link 'Post 4'
    expect(current_path).to eq user_post_path(@user1, @post4)
  end

  it "click on See all posts to redirect to user's post's index page" do
    visit user_path(@user1)
    click_link 'See all posts'
    expect(current_path).to eq user_posts_path(@user1)
  end
end
