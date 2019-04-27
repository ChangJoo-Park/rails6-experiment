class Post < ApplicationRecord
  has_rich_text :content
  belongs_to :user
  # On when production ready
  # has_paper_trail on: [:update :destroy]
end
