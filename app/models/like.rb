class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'

  after_create :increment_likes_counter

  def increment_likes_counter
    post.increment!(:likes_counter)
    post.save
    post.reload
  end

end