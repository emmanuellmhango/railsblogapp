class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  after_create :increment_comments
  def increment_comments
    post.increment!(:comments_counter)
    post.save
    post.reload
  end
end
