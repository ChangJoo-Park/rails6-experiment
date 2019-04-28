class Post < ApplicationRecord
  validates :title, presence: true

  has_rich_text :content
  belongs_to :user
  has_many :comments
  # On when production ready
  # has_paper_trail on: [:update :destroy]

  before_save :set_published_at


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
