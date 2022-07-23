class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable
        #  :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true
  validates :post_counter,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts
    posts.last(3)
  end

  def is?(requested_role)
    role == requested_role.to_s
  end

  def admin?
    role == 'admin'
  end

  def generate_jwt
    JWT.encode({ id:, exp: 60.days.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end
end
