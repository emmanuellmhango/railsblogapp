class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # before_action :authenticate_user!
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable
  before_validation :set_default_values

  validates :name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  def admin?
    role == 'admin'
  end

  def recent_posts
    posts.limit(3).order(created_at: :DESC)
  end

  private

  def set_default_values
    self.posts_counter ||= 0
  end
end
