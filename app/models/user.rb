class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # On when production ready
  # has_paper_trail on: [:update :destroy]
  has_many :posts
  has_many :comments

  private
    def self.find_by_id_with_posts(user_id)
      self.includes(:posts).find(user_id)
    end
end
