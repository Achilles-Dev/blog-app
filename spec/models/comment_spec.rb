require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#counter_updater' do
    user1 = User.create!(name: 'Solo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                         bio: 'FullStack developer from Ghana.', post_counter: 0)
    post1 = Post.create!(title: 'Solo', text: 'This is my first post', user_id: user1.id, comments_counter: 0,
                         likes_counter: 0)
    subject { Comment.create(post: post1, user: user1, text: 'Hi Tom!') }

    it 'updates the comments counter' do
      subject.counter_updater
      expected_value = 1
      expect(post1.comments_counter).to eq(expected_value)
    end
  end
end
