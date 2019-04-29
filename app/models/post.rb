class Post < ApplicationRecord
  before_save :set_published_at

  validates :title, presence: true

  acts_as_favoritable

  has_rich_text :content

  belongs_to :user

  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  # https://rubyplus.com/articles/4241-Tagging-from-Scratch-in-Rails-5

  def self.all_by_user(user)
    # TODO: raise error if user not found
    self.where(user: user).except(:content)
  end

  def self.published_by_user(user)
    # TODO: raise error if user not found
    puts "SELF.PUBLISHED_BY_USER"
    self.includes([:tags, :taggings]).except(:content).where(user: user, published: true)
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
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
