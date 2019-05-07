# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :post, counter_cache: true
  belongs_to :user
end
