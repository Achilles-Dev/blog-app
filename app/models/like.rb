class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def counter_updater
    post.likes_counter = post.likes.count
    Post.find(post.id).update(likes_counter: post.likes.count)
  end
end
