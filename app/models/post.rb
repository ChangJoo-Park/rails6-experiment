class Post < ApplicationRecord
  before_save :set_published_at

  validates :title, presence: true

  acts_as_favoritable

  has_rich_text :content
  belongs_to :user
  has_many :comments

  # https://rubyplus.com/articles/4241-Tagging-from-Scratch-in-Rails-5

  def self.all_by_user(user)
    # TODO: raise error if user not found
    self.where(user: user).except(:content)
  end

  def self.published_by_user(user)
    # TODO: raise error if user not found
    puts "SELF.PUBLISHED_BY_USER"
    self.where(user: user, published: true).except(:content)
  end

  private
    def set_published_at
      if self.published?
        self.published_at = DateTime.now
      else
        self.published_at = nil
      end
    end
end
