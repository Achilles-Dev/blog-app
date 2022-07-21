class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_comments_count
  after_destroy :update_comments_count

  private

  def counter_updater
    post.update(comments_counter: post.comments.length)
  end
end
