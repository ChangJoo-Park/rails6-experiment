class UserProfile < ApplicationRecord
  # TODO: Add unique validation for username
  belongs_to :user
end
