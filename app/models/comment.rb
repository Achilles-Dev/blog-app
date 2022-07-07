class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def post_comements_counter_updater
    post.comments_counter = post.comments.count
  end
end
