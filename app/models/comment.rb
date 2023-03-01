class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_create :increment_comments_counter
  def increment_comments_counter
    post.increment!(:comments_counter)
    post.save
    post.reload
  end
end
