# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post!

  def create
    current_user.favorite(@post)

    render "posts/show"
  end

  def destroy
    current_user.unfavorite(@post)

    render "posts/show"
  end

  private

  def find_post!
    @post = Post.find(params[:post_id])
  end
end
