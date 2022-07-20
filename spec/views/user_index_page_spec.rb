require 'rails_helper'

RSpec.describe 'User index Page', type: :feature do
  before :each do
    @user1 = User.create(name: 'Oybek', post_counter: 0, email: 'user@example.com', password: 'password',
                         confirmed_at: '2022-07-19 22:25:13.71382')
    @user2 = User.create(name: 'Solomon', post_counter: 2, email: 'user2@example.com', password: 'password2',
                         confirmed_at: '2022-06-19 20:25:13.71382')
    @user3 = User.create(name: 'Sentayhu', post_counter: 5, email: 'user4@example.com', password: 'password4',
                         confirmed_at: '2022-06-24 13:25:13.71382')
  end

  it 'can see the names of all users' do
    visit users_path
    expect(page).to have_content 'Oybek'
    expect(page).to have_content 'Solomon'
    expect(page).to have_content 'Sentayhu'
  end

  it 'can see the number of posts for each user' do
    visit users_path
    expect(page).to have_content('Number of posts: 2')
    expect(page).to have_content('Number of posts: 0')
    expect(page).to have_content('Number of posts: 5')
  end

  it 'can see the the profile image for a user' do
    visit users_path
    expect(page).to have_css("img[alt='Profile']")
  end

  it "click on Oybek to redirect to user's show page" do
    visit users_path
    click_link 'Oybek'
    expect(current_path).to eq user_path(@user1.id)
  end

  it "click on Solomon to redirect to user's show page" do
    visit users_path
    click_link 'Solomon'
    expect(current_path).to eq user_path(@user2.id)
  end
end
