# frozen_string_literal: true

class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # On when production ready
  # has_paper_trail on: [:update :destroy]
  has_one :user_profile
  has_many :posts
  has_many :comments
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :following
  has_many :followers, through: :passive_relationships, source: :follower

  after_create :build_user_profile

  def avatar(size=256)
    if user_profile.avatar.present?
      user_profile.avatar.variant(resize: size)
    else
      "https://api.adorable.io/avatars/#{size}/#{email}"
    end
  end

  def build_user_profile
    self.user_profile = UserProfile.new(user: self)
    user_profile.save
  end

  def favorites_post_only_published
    favorite_posts.where(published: true)
  end
  def favorite(post)
    favorites.find_or_create_by(post: post)
  end

  def unfavorite(post)
    favorites.where(post: post).destroy_all
    post.reload
  end

  def favorited?(post)
    favorites.find_by(post_id: post.id).present?
  end

  def following?(other_user)
    active_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    active_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(following_id: other_user.id).destroy
  end
end
