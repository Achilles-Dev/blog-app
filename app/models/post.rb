class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  validates :title, presense: true, length: { in: 1..250 }
  validates :comments_counter, presence: true,
                               numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, presence: true,
                            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def counter_updater
    user.post_counter = user.posts.count
    User.find(user.id).update(post_counter: user.posts.count)
  end

  def last_five_comments
    comments.last(5)
  end
end
