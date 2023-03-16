class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, class_name: 'Post'

  after_create :update_counter
  after_destroy :decrement_comments

  def update_counter
    post.update(comments_counter: post.comments.count)
  end

  def decrement_comments
    post.decrement!(:comments_counter)
  end
end
