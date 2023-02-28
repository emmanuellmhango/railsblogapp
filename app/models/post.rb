class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  after_create :increment_post_counter

  def increment_post_counter
    user.increment!(:posts_counter)
    user.save
    user.reload
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
