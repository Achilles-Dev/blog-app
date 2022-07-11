class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def counter_updater
    post.comments_counter = post.comments.length
  end
end
