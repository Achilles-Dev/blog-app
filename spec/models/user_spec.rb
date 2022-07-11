require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create!(name: 'Solo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'FullStack developer from Ghana.', post_counter: 0) }

  before { subject.save }

  it 'name must not be blank' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'post_counter must be an integer' do
    subject.post_counter = '2s'
    expect(subject).to_not be_valid
  end

  it 'post_counter must greater than or equal to zero' do
    subject.post_counter = -4
    expect(subject).to_not be_valid
  end

  it 'should return zero user posts' do
    expected_value = 0
    expect(subject.last_three_posts.count).to eq(expected_value)
  end

  it 'should return 1 user posts' do
    post1 = Post.new(title: 'Solo', text: 'This is my first post')
    subject.posts.push(post1)
    expected_value = 1
    expect(subject.last_three_posts.length).to eq(expected_value)
  end

  it 'should return 3 user posts' do
    post1 = Post.new(title: 'Solo', text: 'This is my first post')
    post2 = Post.new(title: 'Solo', text: 'This is my second post')
    post3 = Post.new(title: 'Solo', text: 'This is my third post')
    post4 = Post.new(title: 'Solo', text: 'This is my last post')
    subject.posts.push(post1)
    subject.posts.push(post2)
    subject.posts.push(post3)
    subject.posts.push(post4)
    expected_value = 3
    expect(subject.last_three_posts.length).to eq(expected_value)
  end
end
