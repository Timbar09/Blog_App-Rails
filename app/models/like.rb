class Like < ApplicationRecord
  validates :author_id, :post_id, presence: true
  validates :author_id, :post_id, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :update_likes_counter

  private

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
