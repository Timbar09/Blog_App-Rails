class Comment < ApplicationRecord
  validates :author_id, :post_id, :text, presence: true
  validates :author_id, :post_id, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :update_comments_counter

  private

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
