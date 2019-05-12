# frozen_string_literal: true

class UsersController < ApplicationController
  layout "users"

  before_action :set_user
  before_action :redirect_when_not_same_user, only: %i[settings draft]

  def show
  end

  def published
    @posts = Post.published_by_user(@user)
  end

  def draft
    @unpublished_posts = Post.draft_by_user(@user)
  end

  def favorites
    @posts = current_user.favorites.includes(:post).order(created_at: :desc)
  end

  def followers
    @followers = @user.followers
  end

  def followings
    @followings = @user.followings
  end

  def settings
  end

  private
  def set_user
    @user = User.includes(:user_profile).find(params[:user_id])
    @same_user = current_user == @user
  end

  def redirect_when_not_same_user
    redirect_back(fallback_location: @user) unless @same_user
  end
end
