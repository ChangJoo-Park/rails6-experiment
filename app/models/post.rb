class Post < ApplicationRecord
  validates :title, presence: true

  has_rich_text :content
  belongs_to :user
  has_many :comments
  # On when production ready
  # has_paper_trail on: [:update :destroy]

  before_save :set_published_at

  private
    def set_published_at
      if self.published?
        self.published_at = DateTime.now
      else
        self.published_at = nil
      end
    end
end
