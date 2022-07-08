require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#counter_updater' do
    let(:user) do
      User.create!(name: 'Solo', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                   bio: 'FullStack developer from Ghana.', post_counter: 1)
    end
    let(:post) do
      Post.create!(title: 'Post', user_id: user.id, text: 'Some text', comments_counter: 1, likes_counter: 0)
    end

    it 'updates the comments counter' do
      # post.comments.create(user:)
      expect(post.comments_counter).to eq 1
    end
  end
end
