class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_create :increment_likes

  def increment_likes
    post.increment!(:likes_counter)
    post.save
    post.reload
  end
end
