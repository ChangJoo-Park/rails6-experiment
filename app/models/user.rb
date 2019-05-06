# frozen_string_literal: true

class User < ApplicationRecord
  validates :username, presence: :true, uniqueness: { case_sensitive: false }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # On when production ready
  # has_paper_trail on: [:update :destroy]
  has_many :posts
  has_many :comments
  has_one :user_profile
  has_many :favorites, dependent: :destroy

  after_create :build_user_profile

  def build_user_profile
    self.user_profile = UserProfile.new(user: self)
    user_profile.save
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
end
