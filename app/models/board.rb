class Board < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true

  belongs_to :last_post, class_name: 'Post'

  after_create :update_cache

  def update_cache
    self.topic_count = Topic.where(board_id: id).count
    self.post_count = Post.joins(:topic).where('topics.board_id' => id).count
    if post_count > 0
      self.last_post_id = Post.joins(:topic).where('topics.board_id' => id).order(:created_at).last.id
    end
    save
  end
end
