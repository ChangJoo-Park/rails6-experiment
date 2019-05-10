# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.includes(:user_profile).find(params[:id])
    @posts = Post.published_by_user(@user)
    @unpublished_posts = Post.draft_by_user(@user)
    @same_user = current_user == @user
  end
end
