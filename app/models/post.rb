class Post < ApplicationRecord
  before_destroy :decrease_post_counter
  belongs_to :author, class_name: 'User', foreign_key: 'user_id', autosave: true
  has_many :likes
  has_many :comments

  validates :title, presence: { strict: true }, length: { minimum: 3, maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :update_post_counter

  def update_post_counter
    author.increment!(:post_counter)
  end

  def decrease_post_counter
    self.author.post_counter = self.author.post_counter -1
  end

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
