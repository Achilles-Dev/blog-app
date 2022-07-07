class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  def counter_updater
    user.post_counter = user.posts.count
    User.find(user.id).update(post_counter: user.posts.count)
  end

  def last_five_comments
    comments.last(5)
  end
end
