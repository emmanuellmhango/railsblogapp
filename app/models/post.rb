class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  after_create :increment_posts_counter

  def increment_posts_counter
    user.increment!(:posts_counter)
    user.save
    user.reload
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
