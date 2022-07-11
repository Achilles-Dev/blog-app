class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def counter_updater
    post.likes_counter = post.likes.length
  end
end
