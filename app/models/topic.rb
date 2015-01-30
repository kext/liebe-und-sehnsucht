class Topic < ActiveRecord::Base
  belongs_to :board
  has_many :posts

  belongs_to :last_post_user, class_name: 'User'
  belongs_to :first_post_user, class_name: 'User'

  validates :title, presence: true
  validates :board_id, presence: true

  after_create :update_cache

  def update_cache
    p = Post.where(topic_id: id).order(:created_at)
    self.post_count = p.count
    if p.count > 0
      self.first_post_at = p.first.created_at
      self.first_post_user_id = p.first.user_id
      self.last_post_at = p.last.created_at
      self.last_post_user_id = p.last.user_id
    end
    save
  end
end
