class Post < ApplicationRecord
  before_validation :set_default_values

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :user, class_name: 'User', foreign_key: :author_id
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id

  after_create :increment_posts_counter
  after_save :update_counter

  def update_counter
    user.update(posts_counter: author.posts.count)
  end

  def increment_posts_counter
    user.increment!(:posts_counter)
    user.save
    user.reload
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def set_default_values
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end
end
