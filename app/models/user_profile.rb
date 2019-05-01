class UserProfile < ApplicationRecord
  # TODO: Add unique validation for username
  belongs_to :user
  has_one_attached :avatar
end
