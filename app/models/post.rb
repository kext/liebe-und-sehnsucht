class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  validates :content, presence: true
  validates :topic_id, presence: true
  validates :user_id, presence: true

  after_commit do
    topic.update_cache
    topic.board.update_cache
  end
end
