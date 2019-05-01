class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # On when production ready
  # has_paper_trail on: [:update :destroy]
  has_many :posts
  has_many :comments
  has_one :user_profile

  acts_as_favoritor

  after_create :build_user_profile

  def build_user_profile
    self.user_profile = UserProfile.new(user: self)
    self.user_profile.save
  end
end
