require 'rails_helper'

RSpec.describe Post, type: :model do
  user1 = User.create!(name: 'Solo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                       bio: 'FullStack developer from Ghana.', post_counter: 0)
  subject do
    Post.create!(title: 'Solo', text: 'This is my first post', user_id: user1.id, comments_counter: 0, likes_counter: 0)
  end

  before { subject.save }

  it 'title must not be blank' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title must not exceed 250 characters' do
    subject.title = 'Solo' * 70
    expect(subject).to_not be_valid
  end

  it 'comments_counter must be an integer' do
    subject.comments_counter = 'three'
    expect(subject).to_not be_valid
  end

  it 'likes_counter must be an integer' do
    subject.likes_counter = 'four'
    expect(subject).to_not be_valid
  end

  it 'comments_counter must greater than or equal to zero' do
    subject.comments_counter = -4
    expect(subject).to_not be_valid
  end

  it 'likes_counter must greater than or equal to zero' do
    subject.likes_counter = -2
    expect(subject).to_not be_valid
  end

  describe '#last_five_comments' do
    it 'should return zero post comment' do
      expected_value = 0
      expect(subject.last_five_comments.count).to eql(expected_value)
    end

    it 'should return 1 post comment' do
      subject.comments = [Comment.new(post: subject, user: user1, text: 'Hi Tom 1!')]
      expected_value = 1
      expect(subject.last_five_comments.count).to eql(expected_value)
    end

    it 'should return 5 post comments' do
      comment1 = Comment.new(post: subject, user: user1, text: 'Hi Tom 1!')
      comment2 = Comment.new(post: subject, user: user1, text: 'Hi Tom 2!')
      comment3 = Comment.new(post: subject, user: user1, text: 'Hi Tom 3!')
      comment4 = Comment.new(post: subject, user: user1, text: 'Hi Tom 4!')
      comment5 = Comment.new(post: subject, user: user1, text: 'Hi Tom 5!')
      comment6 = Comment.new(post: subject, user: user1, text: 'Hi Tom 6!')
      subject.comments.push(comment1)
      subject.comments.push(comment2)
      subject.comments.push(comment3)
      subject.comments.push(comment4)
      subject.comments.push(comment5)
      subject.comments.push(comment6)
      expected_value = 5
      expect(subject.last_five_comments.count).to eql(expected_value)
    end
  end

  describe '#counter_updater' do
    it 'update post_counter of user' do
      subject.counter_updater
      expected_value = 1
      expect(subject.user.post_counter).to eql(expected_value)
    end
  end
end
