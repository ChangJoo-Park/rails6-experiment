# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post!

  def create
    current_user.favorite(@post)
    redirect_back(fallback_location: @post)
  end

  def destroy
    current_user.unfavorite(@post)
    redirect_back(fallback_location: @post)
  end

  private

  def find_post!
    @post = Post.find(params[:post_id])
  end
end
