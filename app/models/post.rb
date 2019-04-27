class Post < ApplicationRecord
  has_rich_text :content
  # On when production ready
  # has_paper_trail on: [:update :destroy]
end
