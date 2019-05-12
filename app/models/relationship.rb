class Relationship < ApplicationRecord
  belongs_to :following, class_name: "User", foreign_key: :following_id, primary_key: :id
  validates :following_id, presence: true
end
