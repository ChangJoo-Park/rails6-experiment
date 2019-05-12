class Relationship < ApplicationRecord
  belongs_to :following, class_name: "User", foreign_key: :following_id, primary_key: :id
  belongs_to :follower, class_name: "User"
  validates :following_id, presence: true
end
