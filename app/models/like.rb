class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :counter_updater
  after_destroy :counter_updater

  private

  def counter_updater
    post.update(likes_counter: post.likes.length)
  end
end
