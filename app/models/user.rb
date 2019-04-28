class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # On when production ready
  # has_paper_trail on: [:update :destroy]
  has_many :posts
  has_many :comments
  acts_as_favoritor
end
