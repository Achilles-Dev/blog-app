class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :counter_updater
  after_destroy :counter_updater

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def last_five_comments
    comments.last(5)
  end

  private

  def counter_updater
    user.update(post_counter: user.posts.length)
  end
end
