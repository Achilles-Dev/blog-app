class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def counter_updater
    post.comments_counter = post.comments.count
    Post.find(post.id).update(comments_counter: post.comments.count)
  end
end
