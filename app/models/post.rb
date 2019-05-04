# frozen_string_literal: true

class Post < ApplicationRecord
  before_save :set_published_at

  validates :title, presence: true

  has_rich_text :content
  has_one_attached :cover

  belongs_to :user

  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :favorites, dependent: :destroy

  # https://rubyplus.com/articles/4241-Tagging-from-Scratch-in-Rails-5

  def self.feeds
    # FIXME: change when completed

    with_attached_cover
      .except(:content)
      .includes([:tags, :cover_attachment, user: [user_profile: :avatar_attachment]])
      .order(created_at: :desc)
      .limit(10)
    # .where({ published: true })
  end

  def self.all_by_user(user)
    # TODO: raise error if user not found
    where(user: user).except(:content)
  end

  def self.published_by_user(user, same_user)
    with_attached_cover
      .includes(:tags)
      .except(:content)
      .where(user: user, published: !same_user)
      .order(created_at: :desc)
  end

  def self.tagged_with(name)
    Tag.find_by!(name: name).posts.limit(20).includes([:tags, :cover_attachment, user: [user_profile: :avatar_attachment]])
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip.downcase).first_or_create!
    end
  end

  def set_published_at
    self.published_at = (published ? DateTime.now.in_time_zone : nil)
  end
end
