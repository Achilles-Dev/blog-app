class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def post_likes_counter
    post.likes_counter = post.likes.count
  end
end
